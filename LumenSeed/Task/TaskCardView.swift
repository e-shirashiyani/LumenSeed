//
//  TaskCardView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI
import CoreData
import AVFoundation
struct TaskCardView: View {
    @ObservedObject var task: TaskEntity
    @Environment(\.managedObjectContext) private var viewContext
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if (task.pomodoroCount != 0 && task.pomodoroDoneCount >= task.pomodoroCount) || task.isDone {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                        .scaledToFill()
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.black)
                        .scaledToFill()
                        .frame(width: 14, height: 14)
                        .onTapGesture {
                            markTaskAsDone(task)
                        }
                }
                
                if let title = task.title {
                    Text("\(title)")
                        .strikethrough((task.pomodoroCount != 0 && task.pomodoroDoneCount >= task.pomodoroCount) || task.isDone, color: .gray)
                }
                
                Spacer()
                
                if task.pomodoroCount > 0 {
                    HStack(spacing: 2) {
                        Text("\(task.pomodoroDoneCount)/\(task.pomodoroCount)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            if let taskDescription = task.taskDescription {
                Text(taskDescription)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .strikethrough((task.pomodoroCount != 0 && task.pomodoroDoneCount >= task.pomodoroCount) || task.isDone, color: .gray)
                    .padding(.leading, 20)
            }
            
            HStack {
                ForEach(Array(task.tagSet.prefix(2)), id: \.self.id) { tag in
                    let colorHex = tag.color
                    let color = Color(hex: colorHex) ?? .black
                    
                    Text(tag.name)
                        .foregroundColor(color)
                        .font(.system(size: 10))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(color.opacity(0.3))
                        .cornerRadius(5)
                }
                Spacer()
            }
            .padding(.top, 6)
            .padding(.leading, 20)
        }
        .padding(.all, 8)
    }

    private func markTaskAsDone(_ task: TaskEntity) {
        task.isDone = true
        task.pomodoroDoneCount = task.pomodoroCount
        saveContext()
        playSound() // Play sound when task is marked as done
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "done", withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file.")
        }
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample TaskEntity for the preview using an in-memory context
        let persistenceController = PersistenceController(inMemory: true)
        let context = persistenceController.container.viewContext
        
        // Create a sample TaskEntity for preview
        let sampleTaskEntity = TaskEntity(context: context)
        sampleTaskEntity.title = "Finish SwiftUI Tutorial"
        sampleTaskEntity.taskDescription = "Complete the SwiftUI tutorial and review all concepts."
        sampleTaskEntity.pomodoroCount = 4
        sampleTaskEntity.pomodoroDoneCount = 2
        
        // Create some sample tags
        let tag1 = TagEntity(context: context)
        tag1.name = "Work"
        tag1.color = "#FF5733" // Example hex color
        
        let tag2 = TagEntity(context: context)
        tag2.name = "Urgent"
        tag2.color = "#3295a8" // Example hex color
        
        sampleTaskEntity.tags = NSSet(array: [tag1, tag2])
        
        // Save the context to avoid unsaved object issues
        try? context.save()
        
        return TaskCardView(task: sampleTaskEntity)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
