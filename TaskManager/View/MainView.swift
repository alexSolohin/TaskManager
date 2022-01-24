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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var projects: FetchedResults<ProjectDataM>
    
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        VStack {
            List(projects) { project in
                Text(project.nameGoal ?? "Default")
            }
            Button("Add") {
                let goalNames = ["First goal", "Second goal", "Third Goal"]
                
                let chooseGoal = goalNames.randomElement()!
                
                let project = ProjectDataM(context: moc)
                project.id = UUID()
                project.nameGoal = chooseGoal
                
                try? moc.save()
                
            }
            TabView {
                TasksPageView().tabItem {
                    Image("TaskbarIcon")
                    Text("tasks") }.tag(1)
                CalendarView().tabItem {
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

}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
