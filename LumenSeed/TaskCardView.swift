//
//  TaskCardView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI

struct TaskCardView: View {
    let task: Task

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.6), radius: 2, x: 0, y: 1)
            
            HStack {
                Circle()
                    .fill(task.tagColor)
                    .frame(width: 10, height: 10)
                    .padding(.leading)
                Text(task.description)
//                    .padding()
                Spacer()
                Text("0/2")
                    .foregroundStyle(.gray)
                    .padding(.trailing)
            }
            .padding(.all,8)
        }
        .frame(height: 60)
        .padding(.horizontal,8)
        .padding(.bottom,12)
    }
}
#Preview {
    TaskCardView(task: Task(description: "Test1", category: "Work", tagColor: Color.red, pomodoroCount: 1))
}
