//
//  ChatGPTApp.swift
//  ChatGPT
//
//  Created by Danila Gorbunov on 24.04.2023.
//

import SwiftUI

@main
struct ChatGPTApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
