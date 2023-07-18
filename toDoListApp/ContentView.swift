//
//  ContentView.swift
//  toDoListApp
//
//  Created by Scholar on 7/14/23.
//

import SwiftUI

struct ContentView: View {
    @State var toDoItems: [ToDoItem] = []
    @State private var showNewTask = false
    var body: some View {
        VStack {
            HStack{
                Text("To Do List")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                Spacer()
                Button(action: {
                    self.showNewTask = true
                }) {
                Text("+")
                    
                }
            }.padding()
            Spacer()
        }
        .padding()
        
        List {
                ForEach (toDoItems) { toDoItem in
                    if toDoItem.isImportant == true {
                        Text("‼️" + toDoItem.title)
                    } else {
                        Text(toDoItem.title)
                    }
                    }
        }.listStyle(.plain)
        
        if showNewTask {
            NewToDoView(toDoItems: $toDoItems, title: "", isImportant: false,showNewTask: $showNewTask)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
