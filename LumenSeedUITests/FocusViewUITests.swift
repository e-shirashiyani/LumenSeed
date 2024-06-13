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
        // Add a new task
        app.buttons["Add Task"].tap()
        
        let taskTitleField = app.textFields["EnterTaskTitle"]
        XCTAssertTrue(taskTitleField.waitForExistence(timeout: 5), "Task title field does not exist")
        taskTitleField.tap()
        taskTitleField.typeText("New Task")
        
        // Increment pomodoros
        let steppers = app.steppers["PomodorosStepper"]
        XCTAssertTrue(steppers.waitForExistence(timeout: 5), "Pomodoro stepper does not exist")
        
//        let incrementButton = steppers.buttons["Increment"]
//        XCTAssertTrue(incrementButton.waitForExistence(timeout: 5), "Increment button does not exist")
//        incrementButton.tap()
//        incrementButton.tap()
        
        app.buttons["SaveButton"].tap()
        
        // Verify the task is added
        let newTask = app.staticTexts["New Task"]
        XCTAssertTrue(newTask.waitForExistence(timeout: 5), "New task was not added")
        
        // Delete the new task
        newTask.swipeLeft()
        app.buttons["Delete"].tap()
        
        // Confirm deletion
        let deleteAlert = app.alerts["Delete Task"]
        XCTAssertTrue(deleteAlert.waitForExistence(timeout: 5), "Delete alert did not appear")
        deleteAlert.scrollViews.otherElements.buttons["Delete"].tap()
        
        // Verify the task is deleted
        XCTAssertFalse(newTask.exists, "New task was not deleted")
    }
}
