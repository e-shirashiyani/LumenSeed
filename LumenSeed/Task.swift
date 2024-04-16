//
//  Task.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI
struct Task: Identifiable {
    let id = UUID()
    var description: String
    var category: String
    var tagColor: Color
    var pomodoroCount: Int
}
