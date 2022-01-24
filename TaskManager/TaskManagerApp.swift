//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by user on 04.12.2021.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject private var aplicationData = AplicationData()
   
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, aplicationData.container.viewContext)
            
        }
    }
}
