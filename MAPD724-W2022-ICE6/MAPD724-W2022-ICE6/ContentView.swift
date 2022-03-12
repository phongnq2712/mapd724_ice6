/**
 * MAPD724 - ICE 6
 * File Name:    ContentView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   March 12th, 2022
 */

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    var body: some View {
        VStack {
           Image(uiImage: self.image)
               .resizable()
               .scaledToFill()
               .frame(minWidth: 0, maxWidth: .infinity)
               .edgesIgnoringSafeArea(.all)

           Button(action: {
               self.isShowPhotoLibrary = true
           }) {
               HStack {
                   Image(systemName: "photo")
                       .font(.system(size: 20))

                   Text("Photo library")
                       .font(.headline)
               }
               .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
               .background(Color.blue)
               .foregroundColor(.white)
               .cornerRadius(20)
               .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
     
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
