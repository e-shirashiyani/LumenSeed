//
//  Tag.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/16/24.
//

import SwiftUI
struct Tag: Identifiable, Equatable, Hashable  {
    let id: UUID
    let name: String
    let color: Color
    
    // Implement Equatable to compare tags based on their id
       static func == (lhs: Tag, rhs: Tag) -> Bool {
           return lhs.id == rhs.id
       }
}
