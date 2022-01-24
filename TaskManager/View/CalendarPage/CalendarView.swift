//
//  CalendarView.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 19.01.2022.
//

import SwiftUI

struct CalendarView: View {
   
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center) {
                ForEach(1...100, id: \.self) {
                    Text("Row \($0)")
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
