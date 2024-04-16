//
//  AppDelegate.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/13/24.
//

import AVFoundation
import UIKit
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestNotificationPermission()
        let audioSession = AVAudioSession.sharedInstance()
               do {
                   try audioSession.setCategory(.playback, mode: .default)
                   try audioSession.setActive(true)
               } catch {
                   print("Failed to set up audio session: \(error)")
               }
               
               return true
    }
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Notification permission denied because: \(error.localizedDescription).")
            }
        }
    }
}

//func scheduleNotification(for timeRemaining: TimeInterval) {
//    // First, remove any existing notification with the same identifier
//    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerUpdate"])
//
//    let content = UNMutableNotificationContent()
//    let minutes = Int(timeRemaining) / 60
//    let seconds = Int(timeRemaining) % 60
//    content.title = "Timer Running"
//    content.body = "Time remaining: \(minutes) minutes, \(seconds) seconds."
//    content.sound = UNNotificationSound.default
//
//    // Use a very short time interval for testing, or match it with the update frequency you prefer
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)  // Update every minute
//
//    let request = UNNotificationRequest(identifier: "timerUpdate", content: content, trigger: trigger)
//
//    UNUserNotificationCenter.current().add(request) { error in
//        if let error = error {
//            print("Error scheduling notification: \(error)")
//        } else {
//            print("Notification scheduled with \(minutes) minutes and \(seconds) seconds remaining")
//        }
//    }
//}
//func cancelNotification() {
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerFinished"])
//    }
//
//}
//Button(action: {
//    // Your action here
//}) {
//    HStack {
//        Image(systemName: "gearshape.fill")       .font(.title3)
//            .padding(0)
//        
//        Text("Setting")
//            .fontWeight(.bold)
//            .padding(0)
//    }
//    .foregroundColor(AppColors.secondry)
//    .frame(width: 135, height: 60)
//}



//struct TimerView: View {
//    @State private var totalTime: CGFloat = 300 * 60  // Default total time set to 300 minutes
//    @State private var timeRemaining: CGFloat = 25 * 60  // Start with 25 minutes
//    @State private var timerRunning = false
//    @State private var timerPaused = false
//
//    var body: some View {
//        VStack(spacing: 10) {
//            ProgressCircleView(totalTime: $totalTime, timeRemaining: $timeRemaining)
//
//            if !timerRunning && !timerPaused {
//                Button("Start") {
//                    startTimer()
//                }
//                .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: .white, width: 160))
//            } else if timerRunning {
//                Button("Pause") {
//                    pauseTimer()
//                }
//                .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: AppColors.secondry, width: 145, isOutline: true))
//            } else if timerPaused {
//                HStack(spacing: 20) {
//                    Button("Continue") {
//                        continueTimer()
//                    }
//                    .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: .white, width: 145))
//
//                    Button("Stop") {
//                        resetTimer()
//                    }
//                    .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: AppColors.secondry, width: 145, isOutline: true))
//                }
//            }
//        }
//        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
//            guard timerRunning else { return }
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//                if Int(timeRemaining) % 60 == 0 {
//                    scheduleNotification(for: timeRemaining)
//                }
//            } else {
//                resetTimer()
//                scheduleNotification(for: 0)  // Optionally notify when timer finishes
//            }
//        }
//    }
//
//    func startTimer() {
//        if timeRemaining <= 0 {
//            timeRemaining = totalTime  // Reset if time is up or not set
//        }
//        timerRunning = true
//        timerPaused = false
//        scheduleNotification(for: timeRemaining)
//    }
//
//    func pauseTimer() {
//        timerRunning = false
//        timerPaused = true
//        cancelNotification()
//    }
//
//    func continueTimer() {
//        timerRunning = true
//        timerPaused = false
//    }
//
//    func resetTimer() {
//        timerRunning = false
//        timerPaused = false
//        timeRemaining = totalTime
//        cancelNotification()
//    }
//
//    func scheduleNotification(for timeRemaining: TimeInterval) {
//        let content = UNMutableNotificationContent()
//        content.title = "Timer Countdown"
//        content.body = "Your timer will end in \(Int(timeRemaining / 60)) minutes."
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeRemaining, repeats: false)
//        let request = UNNotificationRequest(identifier: "timerFinished", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error)")
//            }
//        }
//    }
//
//    func cancelNotification() {
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerFinished"])
//    }
//}
