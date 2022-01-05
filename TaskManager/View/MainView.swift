//
//  ContentView.swift
//  TaskManager
//
//  Created by user on 04.12.2021.
//

import SwiftUI
import CoreData
import Foundation

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        TabView {
            TasksView().tabItem {
                Image("TaskbarIcon")
                Text("tasks") }.tag(1)
            Text("Calendar").tabItem {
                Image("CalendarBarIcon")
                Text("calendar")
            }.tag(2)
            Text("Diary").tabItem {
                Image("DiaryBarIcon")
                Text("diary")
            }.tag(3)
            Text("Setting").tabItem {
                Image("SettingbarIcon")
                Text("setting")
            }.tag(4)
        }.accentColor(.green).ignoresSafeArea()

        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
