//
//  TaskView.swift
//  TaskManager
//
//  Created by user on 05.12.2021.
//

import SwiftUI

struct TasksView: View {
    @State var selectedView = 0
    
    var body: some View {
        VStack{
            TasksListSection(selectedView: $selectedView)
            Spacer()
            VStack {
                TabView(selection: $selectedView) {
                    ProjectView(nameProject: "First Project").tag(0)
                    ProjectView(nameProject: "Second Project").tag(1)
                    ProjectView(nameProject: "Third Project").tag(2)
                    ProjectView(nameProject: "Four Project").tag(3)
                }.tabViewStyle(.page(indexDisplayMode: .never))
            }.frame(width: UIScreen.main.bounds.width, height: 60).background(.white)
        }
    }
}

struct TasksListSection: View {
    @Binding var selectedView: Int
    @State var isTap = false
    
    var drag : some Gesture {
        DragGesture()
        .onChanged{_ in self.isTap = true}
        .onEnded{_ in self.isTap = false}
    }
    
    var body: some View {
        
        TabView(selection: $selectedView) {
            TaskListView().tag(0)
            TaskListView().tag(1)
            Text("Third project").tag(2)
            Text("Fourth project").tag(3)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
