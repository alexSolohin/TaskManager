//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by user on 04.12.2021.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
