//
//  TaskListView.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 18.12.2021.
//

import SwiftUI

struct TaskListView: View {
    @State private var select = Set<UUID>()
    @State var tasks : [Task]
        
    var body: some View {
        List {
            Section(header: Text("To Do")) {
                ForEach($tasks, id: \.id) {task in
                 TaskView(task: task, tasks: $tasks)
                }
            }
//            Section(header: Text("Done")) {
//                ForEach($tasks, id: \.doneId) {task in
//                    TaskView(task: task, tasks: $tasks)
//                }
//            }
        }.listStyle(PlainListStyle()).animation(.easeInOut)
    }
    
    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func move(at offsets: IndexSet, to dest: Int)
    {
        tasks.move(fromOffsets: offsets, toOffset: dest)
    }
    
}

struct TaskView: View {
    @Binding    var task: Task
    @State      var done  = false
    @Binding    var tasks: [Task]
    
    var body: some View {
        TaskRect(name: task.name, index: tasks.firstIndex(of: task)).listRowBackground(done ? Color.green : Color.gray)
            .swipeActions(edge: .leading, content:{
            Button{ complete() } label: {
                Label("Complete", systemImage: "heart.fill")
            }.tint(.green)
        })
        .swipeActions(edge: .trailing, content: {
                Button() { print("task") } label: {
                    Label("More", systemImage: "ellipsis.circle.fill")
                }.tint(.indigo)
                Button(role: .destructive) {
                    tasks.remove(at: tasks.firstIndex(of: task)!)} label: {
                    Label("Delete", systemImage: "trash.fill")
                }
            })
    }
    
    func complete()
    {
        done = true
        let index = tasks.firstIndex(of: task)
        if (index != nil) {
            let elem = tasks.remove(at: index!)
            tasks.append(elem)
        }
    }
    

}

struct TaskRect: View {
    var name: String
    var index: Int?
    
    var body: some View {
            HStack {
                VStack{
                    Text(name)
                    Text(String(index ?? 1000)).font(.subheadline)
                }
                Spacer()
                Image(systemName: "heart.fill")
            }.padding()
        }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let task1 = Task(name: "First task", done: false)
        let tasks = [task1!, task1!]
        TaskListView(tasks: tasks)
.previewInterfaceOrientation(.portrait)
    }
}
