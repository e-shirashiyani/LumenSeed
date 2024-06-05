//
//  TaskCardView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI

import SwiftUI

struct TaskCardView: View {
    let task: Task

    var body: some View {
        VStack {
            HStack {
                // Status tags, assuming the first two tags are for status like "work" and "pending"
                ForEach(Array(task.tags.prefix(2)), id: \.self) { tag in
                    Text(tag.name)
                        .foregroundStyle(tag.color)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(tag.color.opacity(0.3))
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
                        .foregroundColor(.lumenGreen)
                        .frame(width: 10, height: 10)
                } else {
                    Circle()
                        .fill(.black)
                        .frame(width: 10, height: 10)
                }
                
                // Task description with hashtag
                VStack(alignment: .leading, spacing: 4) {
                    Text("#\(task.title)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .strikethrough(task.pomodoroDoneCount >= task.pomodoroCount, color: .gray)
                    Text(task.description)
                        .font(.headline)
                        .strikethrough(task.pomodoroDoneCount >= task.pomodoroCount, color: .gray)
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
    }
}

#Preview {
    TaskCardView(task: Task(title: "Tesla", description: "implement button", status: "Pending", tags: [Tag(id: UUID(), name: "work", color: .blue)], pomodoroCount: 2, pomodoroDoneCount: 0, isDone: false))
}
