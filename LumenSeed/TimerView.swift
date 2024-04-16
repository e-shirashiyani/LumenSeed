//
//  TimerView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/3/24.
//

import SwiftUI

import SwiftUI
import UserNotifications

struct TimerView: View {
    @State private var totalTime: CGFloat = 300 * 60  // Default total time set to 300 minutes
    @State private var timeRemaining: CGFloat = 25 * 60  // Start with 25 minutes
    @State private var timerRunning = false
    @State private var timerPaused = false

    var body: some View {
        VStack(spacing: 10) {
            
            ProgressCircleView(totalTime: $totalTime, timeRemaining: $timeRemaining)

            if !timerRunning && !timerPaused {
                Button("Start") {
                    startTimer()
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: .white, width: 160))
            } else if timerRunning {
                Button("Pause") {
                    pauseTimer()
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: AppColors.secondry, width: 145, isOutline: true))
            } else if timerPaused {
                HStack(spacing: 20) {
                    Button("Continue") {
                        continueTimer()
                    }
                    .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: .white, width: 145))

                    Button("Stop") {
                        resetTimer()
                    }
                    .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: AppColors.secondry, width: 145, isOutline: true))
                }
            }
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    guard timerRunning else { return }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        if Int(timeRemaining) % 60 == 0 {
                            scheduleNotification(timeRemaining: timeRemaining, immediately: true)  // Schedule immediately when timer starts

                        }
                    } else {
                        resetTimer()
                    }
                }
    }

    func startTimer() {
        if timeRemaining <= 0 {
            timeRemaining = totalTime  // Reset if time is up or not set
        }
        timerRunning = true
        timerPaused = false
        //schedulePeriodicNotifications(startingFrom: timeRemaining)
        scheduleNotification(timeRemaining: timeRemaining, immediately: true)  // Schedule immediately when timer starts
    }

    func pauseTimer() {
        timerRunning = false
        timerPaused = true
        cancelNotification()
    }

    func continueTimer() {
        timerRunning = true
        timerPaused = false
    }

    func resetTimer() {
        timerRunning = false
        timerPaused = false
        timeRemaining = totalTime
        cancelNotification()
    }
    func scheduleNotification(timeRemaining: TimeInterval, immediately: Bool = false) {
        let notificationIdentifier = "timerNotification"  // Consistent identifier

        // Clear previous notifications to prevent duplicates
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])

        let content = UNMutableNotificationContent()
        content.title = "Timer Running"
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        content.body = "Remaining time: \(minutes) minutes, \(seconds) seconds."
        content.sound = UNNotificationSound.default

        // Determine when the notification should be triggered
        let triggerDelay = immediately ? 1 : 5  // 1 second for immediate, 60 seconds for periodic updates
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(triggerDelay), repeats: false)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }


}
func scheduleTestNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Test Notification"
    content.body = "This is a test of the notification system."
    content.sound = UNNotificationSound.default

    // This will trigger the notification after 10 seconds.
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling test notification: \(error.localizedDescription)")
        } else {
            print("Test notification scheduled")
        }
    }
    
}


func cancelNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerFinished"])
}


#Preview {
    TimerView()
}

