//
//  GitHubAPI_UsersApp.swift
//  GitHubAPI_Users
//
//  Created by chul on 8/24/24.
//

import SwiftUI

@main
struct GitHubAPI_UsersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
