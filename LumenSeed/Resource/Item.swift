//
//  Item.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/3/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
