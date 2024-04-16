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
    @Environment(\.presentationMode) var presentationMode
    @Binding var tasks: [Task]
    
    let categories = ["Work", "Study", "Personal", "Exercise"] // Example categories
    
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
                    .accentColor(Color("AccentColor"))
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
                    .accentColor(Color("AccentColor"))
                    .textFieldStyle(.roundedBorder)
                
                Button("Tags") {
                    showingCategoryPicker = true
                }
                .padding(.all,8)
                .padding(.horizontal,15)
                .font(.system(size: 16))
                .foregroundStyle(.secondry)
                .background(
                    Capsule()
                        .foregroundStyle(.gray.opacity(0.1))
                )
                .actionSheet(isPresented: $showingCategoryPicker) {
                    ActionSheet(title: Text("Select Category"), buttons: categoryButtons())
                }
                .padding(.top)
                
                HStack {
                    Text("Est Pomodoros")
                    Stepper(value: $estimatedPomodoros, in: 1...10) {
                        Text("\(estimatedPomodoros)")
                            .frame(minWidth: 36)
                    }
                    .padding()
                }
                
                
                
//                Button("Select Tag Color") {
//                    showingColorPicker = true
//                }
//                .padding()
//                .foregroundColor(tagColor)
//                .sheet(isPresented: $showingColorPicker) {
//                    ColorPicker("Pick a Tag Color", selection: $tagColor, supportsOpacity: false)
//                        .padding()
//                }
                
                Spacer()
                
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button("Save") {
                        // Logic to save the task with category and tag color
                        let newTask = Task(description: taskDescription, category:selectedCategory, tagColor: tagColor, pomodoroCount: estimatedPomodoros)
                        self.tasks.append(newTask)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
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
    AddTaskSheetView(estimatedPomodoros: .constant(2), tasks: .constant([Task(description: "", category: "", tagColor: .brown, pomodoroCount: 4)]))
}
