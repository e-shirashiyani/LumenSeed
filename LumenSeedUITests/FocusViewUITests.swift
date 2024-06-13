//
//  FocusViewUITests.swift
//  LumenSeedUITests
//
//  Created by e.shirashiyani on 6/13/24.
//

import XCTest
import SwiftUI
import CoreData
@testable import LumenSeed

class FocusViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testAddAndDeleteTask() throws {
        // Navigate to FocusView
        app.buttons["Focus"].tap()
        
        // Add a new task
        app.buttons["Add Task"].tap()
        let taskTitleField = app.textFields["Task Title"]
        taskTitleField.tap()
        taskTitleField.typeText("New Task")
        
        let pomodoroStepper = app.steppers["Pomodoros"]
        pomodoroStepper.buttons["Increment"].tap()
        pomodoroStepper.buttons["Increment"].tap()
        
        app.buttons["Save"].tap()
        
        // Verify the task is added
        let newTask = app.staticTexts["New Task"]
        XCTAssertTrue(newTask.exists)
        
        // Delete the new task
        newTask.swipeLeft()
        app.buttons["Delete"].tap()
        
        // Confirm deletion
        app.alerts["Delete Task"].scrollViews.otherElements.buttons["Delete"].tap()
        
        // Verify the task is deleted
        XCTAssertFalse(newTask.exists)
    }
}
