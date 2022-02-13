//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by user on 04.12.2021.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject var projectModel = ProjectModel()
       
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(projectModel)
            
        }
    }
}
