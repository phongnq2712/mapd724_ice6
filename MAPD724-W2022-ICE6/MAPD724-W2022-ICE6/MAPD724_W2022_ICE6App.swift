//
//  MAPD724_W2022_ICE6App.swift
//  MAPD724-W2022-ICE6
//
//  Created by Phong on 12/03/2022.
//

import SwiftUI

@main
struct MAPD724_W2022_ICE6App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
