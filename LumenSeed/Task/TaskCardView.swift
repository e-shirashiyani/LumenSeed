//
//  TaskCardView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI

import SwiftUI

import SwiftUI
import CoreData

struct TaskCardView: View {
    @ObservedObject var task: TaskEntity

    var body: some View {
        VStack {
            HStack {
                // Display tags if available
                if let title = task.title {
                    Text(title)
                        .foregroundColor(Color.blue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(5)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            HStack {
                // The circle indicator or checkmark
                if task.pomodoroDoneCount >= task.pomodoroCount {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .frame(width: 10, height: 10)
                } else {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 10, height: 10)
                }
                
                // Task description with hashtag
                VStack(alignment: .leading, spacing: 4) {
                    if let title = task.title {
                        Text("#\(title)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .strikethrough(task.pomodoroDoneCount >= task.pomodoroCount, color: .gray)
                    }
                    if let taskDescription = task.taskDescription {
                        Text(taskDescription)
                            .font(.headline)
                            .strikethrough(task.pomodoroDoneCount >= task.pomodoroCount, color: .gray)
                    }
                }
                .padding(.leading)
                
                Spacer()
                
                // Completion counter
                HStack(spacing: 2) {
                    Text("\(task.pomodoroDoneCount)/\(task.pomodoroCount)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 1)
    }
}

//#Preview {
//    TaskCardView(task: Task(title: "Tesla", description: "implement button", status: "Pending", tags: [Tag(id: UUID(), name: "work", color: .blue)], pomodoroCount: 2, pomodoroDoneCount: 0, isDone: false))
//}
