//
//  EditTaskSheetView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 6/21/24.
//

import SwiftUI
import CoreData

struct EditTaskSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task: TaskEntity
    @Environment(\.presentationMode) var presentationMode

    @FetchRequest(
        entity: TagEntity.entity(),
        sortDescriptors: []
    ) private var fetchedTags: FetchedResults<TagEntity>

    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var selectedTags: Set<Tag> = []
    @State private var tags: [Tag] = []
    @State private var pomodoroCount: Int32 = 1
    @State private var showDeleteConfirmation = false // To show delete confirmation alert

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("What would you like to do?")
                    TextField("Enter task title", text: $taskTitle)
                        .padding(.all, 10)
                        .font(.title3)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.top)

                VStack(alignment: .leading) {
                    Text("Description")
                    TextField("What are you working on?", text: $taskDescription)
                        .padding(.all, 10)
                        .font(.title3)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }

                TagListView(selectedTags: $selectedTags, tags: $tags)
                Text("Need a Focus Timer for This Task?")
                    .padding(.top,8)
                HStack {
                    Text("Est Pomodoros")
                    Stepper(value: $pomodoroCount, in: 1...10) {
                        Text("\(pomodoroCount)")
                            .frame(minWidth: 36)
                    }
                }
//                .padding(.all, 4)

                Spacer()

                Button(action: {
                    self.showDeleteConfirmation = true
                }) {
                    Text("Delete Task")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(.lumenRed)
                        .cornerRadius(8)
                }
                .padding(.bottom, 10)
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("Delete Task"),
                        message: Text("Are you sure you want to delete this task? This action cannot be undone."),
                        primaryButton: .destructive(Text("Delete")) {
                            deleteTask()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .navigationBarTitle("Edit Seed", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundStyle(.lumenSecondary)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        task.title = taskTitle
                        task.taskDescription = taskDescription
                        task.pomodoroCount = pomodoroCount
                        task.tagSet = selectedTags
                        saveContext()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(taskTitle.isEmpty ? .gray : Color.lumenSecondary)
                    .disabled(taskTitle.isEmpty)
                }
            }
        }
        .padding()
        .onAppear {
            // Load existing task details into temporary variables
            taskTitle = task.title ?? ""
            taskDescription = task.taskDescription ?? ""
            pomodoroCount = task.pomodoroCount
            loadSelectedTags()
            fetchTags()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func deleteTask() {
        viewContext.delete(task) // Delete the task from the context
        saveContext() // Save the deletion in Core Data
        self.presentationMode.wrappedValue.dismiss() // Dismiss the sheet
    }

    private func fetchTags() {
        let uniqueTags = Set(fetchedTags.map { Tag(id: $0.id!, name: $0.name!, color: $0.color!) })
        tags = Array(uniqueTags)
    }

    private func loadSelectedTags() {
        if let taskTags = task.tagSet as? Set<Tag> {
            selectedTags = taskTags
        }
    }
}

struct EditTaskSheetView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample TaskEntity for the preview using an in-memory Core Data context
        let persistenceController = PersistenceController(inMemory: true)
        let context = persistenceController.container.viewContext
        
        // Create a sample TaskEntity for the preview
        let sampleTaskEntity = TaskEntity(context: context)
        sampleTaskEntity.title = "Finish SwiftUI Tutorial"
        sampleTaskEntity.taskDescription = "Complete the SwiftUI tutorial and review all concepts."
        sampleTaskEntity.pomodoroCount = 4
        
        // Create some sample tags
        let sampleTag = TagEntity(context: context)
        sampleTag.name = "Urgent"
        sampleTag.color = "#FF5733" // Example hex color
        
        sampleTaskEntity.tags = NSSet(array: [sampleTag])
        
        // Save the context to make sure the data is ready for preview
        do {
            try context.save()
        } catch {
            print("Failed to save context in preview: \(error)")
        }

        return EditTaskSheetView(task: sampleTaskEntity)
            .environment(\.managedObjectContext, context)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
