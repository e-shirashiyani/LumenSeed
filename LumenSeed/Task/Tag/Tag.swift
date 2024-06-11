//
//  Tag.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/16/24.
//

import SwiftUI
//    struct Tag: Hashable, Identifiable {
//        var id: UUID
//        var name: String
//        var color: Color
//    
//    // Implement Equatable to compare tags based on their id
//       static func == (lhs: Tag, rhs: Tag) -> Bool {
//           return lhs.id == rhs.id
//       }
//}
struct Tag: Hashable, Identifiable {
    var id: UUID
    var name: String
    var color: String // Store color as hex string
}
