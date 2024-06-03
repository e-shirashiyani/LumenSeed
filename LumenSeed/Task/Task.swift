//
//  Task.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI
struct Task: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var status: String
    var tags: Set<Tag>
    var pomodoroCount: Int
    var pomodoroDoneCount: Int
    var isDone: Bool
}
