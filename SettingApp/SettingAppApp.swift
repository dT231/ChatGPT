//
//  SettingAppApp.swift
//  SettingApp
//
//  Created by Danila Gorbunov on 24.04.2023.
//

import SwiftUI

@main
struct SettingAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
