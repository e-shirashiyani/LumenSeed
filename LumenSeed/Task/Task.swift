//
//  Task.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI
import CoreData

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

extension TaskEntity {
    var tagSet: Set<Tag> {
        get {
            let tags = self.tags as? Set<TagEntity> ?? []
            return Set(tags.map { Tag(id: $0.id ?? UUID(), name: $0.name ?? "", color: $0.color!) })
        }
        set {
            let tagEntities = newValue.map { tag in
                let tagEntity = TagEntity(context: self.managedObjectContext!)
                tagEntity.id = tag.id
                tagEntity.name = tag.name
                tagEntity.color = tag.color
                return tagEntity
            }
            self.tags = NSSet(array: tagEntities)
        }
    }
}
