//
//  AddTaskSheetView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI

struct AddTaskSheetView: View {
    @Binding var estimatedPomodoros: Int
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var selectedCategory: String = "Work"
    @State private var tagColor: Color = .red
    @State private var showingCategoryPicker = false
    @State private var showingColorPicker = false
    @State private var tags: [Tag] = []
    @State private var selectedTags: Set<Tag> = Set()
    @State private var showingTags = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var tasks: [Task]
    
    let categories = ["Work", "Study", "Personal", "Exercise"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Project Name")
                TextField("Enter task title", text: $taskTitle)
                    .padding()
                    .font(.title3)
                    .cornerRadius(50.0)
                    .textFieldStyle(.plain)
                    .background(.gray.opacity(0.1))
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .cornerRadius(8)
                    .accentColor(Color.lumenGreen)
                    .textFieldStyle(.roundedBorder)
                
                Text("Description")
                TextField("What are you working on?", text: $taskDescription)
                    .padding()
                    .font(.title3)
                    .cornerRadius(50.0)
                    .textFieldStyle(.plain)
                    .background(.gray.opacity(0.1))
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .cornerRadius(8)
                    .accentColor(Color.lumenGreen)
                    .textFieldStyle(.roundedBorder)
                
                TagListView(selectedTags: $selectedTags, tags: $tags)
                .padding(.top,8)
                
                HStack {
                    Text("Est Pomodoros")
                    Stepper(value: $estimatedPomodoros, in: 1...10) {
                        Text("\(estimatedPomodoros)")
                            .frame(minWidth: 36)
                    }
                }
                .padding(.all,4)
                
                
                Spacer()
                
            }
            .navigationBarTitle("Task", displayMode: .inline)
            .navigationBarHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        let newTask = 
                        Task(title: taskTitle, description: taskDescription, status: "Pending", tags: selectedTags, pomodoroCount: estimatedPomodoros, pomodoroDoneCount: 0, isDone: false)
                        self.tasks.append(newTask)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundStyle(.lumenSecondary)
                    
                }
            }
        }
        .padding()
    }
    
    private func categoryButtons() -> [ActionSheet.Button] {
        var buttons = categories.map { category in
            ActionSheet.Button.default(Text(category)) {
                selectedCategory = category
            }
        }
        buttons.append(.cancel())
        return buttons
    }
}

#Preview {
    AddTaskSheetView(estimatedPomodoros: .constant(2), tasks: .constant([Task(title: "tesla", description: "implement button", status: "pending", tags: [], pomodoroCount: 2, pomodoroDoneCount: 0, isDone: false)]))
}
