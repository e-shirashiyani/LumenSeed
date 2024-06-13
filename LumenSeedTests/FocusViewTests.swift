//
//  FocusViewTests.swift
//  LumenSeedTests
//
//  Created by e.shirashiyani on 6/13/24.
//

import XCTest
import SwiftUI
import CoreData
@testable import LumenSeed

class FocusViewTests: XCTestCase {
    
    var viewContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        // Initialize an in-memory Core Data stack
        let persistentContainer = NSPersistentContainer(name: "MyDataModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        
        viewContext = persistentContainer.viewContext
    }
    
    func testFetchingTasks() throws {
        // Create mock tasks
        let task1 = TaskEntity(context: viewContext)
        task1.id = UUID()
        task1.title = "Task 1"
        task1.pomodoroCount = 4
        task1.pomodoroDoneCount = 2
        
        let task2 = TaskEntity(context: viewContext)
        task2.id = UUID()
        task2.title = "Task 2"
        task2.pomodoroCount = 6
        task2.pomodoroDoneCount = 5
        
        try viewContext.save()
        
        // Fetch the tasks
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        let fetchedTasks = try viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(fetchedTasks.count, 2)
        XCTAssertEqual(fetchedTasks[0].title, "Task 1")
        XCTAssertEqual(fetchedTasks[1].title, "Task 2")
    }
    
    func testTaskDeletion() throws {
        // Create a mock task
        let task = TaskEntity(context: viewContext)
        task.id = UUID()
        task.title = "Task to delete"
        task.pomodoroCount = 3
        task.pomodoroDoneCount = 1
        
        try viewContext.save()
        
        // Fetch the task
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        var fetchedTasks = try viewContext.fetch(fetchRequest)
        XCTAssertEqual(fetchedTasks.count, 1)
        
        // Delete the task
        viewContext.delete(fetchedTasks[0])
        try viewContext.save()
        
        // Fetch the tasks again
        fetchedTasks = try viewContext.fetch(fetchRequest)
        XCTAssertEqual(fetchedTasks.count, 0)
    }
}
