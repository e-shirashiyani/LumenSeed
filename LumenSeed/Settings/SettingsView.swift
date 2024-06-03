//
//  SettingsView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/15/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isPresented: Bool
    @Binding var pomodoroTime: Int
    @Binding var shortBreakTime: Int
    @Binding var longBreakTime: Int
    
    @State private var autoStartBreaks: Bool = false
    @State private var autoStartPomodoros: Bool = false
    @State private var longBreakInterval: Int = 4
    @State private var autoCheckTasks: Bool = false
    @State private var autoSwitchTasks: Bool = true
    @State private var selectedSound: String = "Kitchen"
    @State private var soundVolume: Double = 50
    
    //  @State variables for the sound settings
    @State private var alarmVolume: Double = 52
    @State private var tickingVolume: Double = 48
    @State private var repeatCount: Int = 1
    @State private var selectedTickingSound: String = "None"
    let tickingSounds = ["None", "Tick", "Tock"]
    
    //  @State variables for the theme settings
    @State private var colorTheme: String = "Red"
    let colorThemes = ["Red", "Blue", "Green"]
    @State private var hourFormat: String = "24-hour"
    @State private var isDarkMode: Bool = true
    @State private var isSmallWindow: Bool = false
    
    //  @State variables for the notification settings
    @State private var reminder: String = "Last"
    let reminderOptions = ["Every", "Last"]
    @State private var reminderTime: Int = 5
    let sounds = ["Kitchen", "Beep", "Chime"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                Form {
                    Section(header: Text("TIMER")) {
                        HStack {
                            Text("Pomodoro")
                            Spacer()
                            Text("\(pomodoroTime / 60) minutes")
                        }
                        Stepper(value: $pomodoroTime, in: 60...3600, step: 60) { }
                        
                        HStack {
                            Text("Short Break")
                            Spacer()
                            Text("\(shortBreakTime / 60) minutes")
                        }
                        Stepper(value: $shortBreakTime, in: 60...3600, step: 60) { }

                        HStack {
                            Text("Long Break")
                            Spacer()
                            Text("\(longBreakTime / 60) minutes")
                        }
                        Stepper(value: $longBreakTime, in: 60...3600, step: 60) { }

                        Toggle("Auto Start Breaks", isOn: $autoStartBreaks)
                        Toggle("Auto Start Pomodoros", isOn: $autoStartPomodoros)
                        
                    }
                    
                    Section(header: Text("TASK")) {
                        Toggle("Auto Check Tasks", isOn: $autoCheckTasks)
                        Toggle("Auto Switch Tasks", isOn: $autoSwitchTasks)
                    }
                    
                    Section(header: Text("SOUND")) {
                        Picker("Alarm Sound", selection: $selectedTickingSound) {
                            ForEach(tickingSounds, id: \.self) { sound in
                                Text(sound)
                            }
                        }
                        Slider(value: $alarmVolume, in: 0...100, step: 1)
                        HStack {
                            Text("repeat")
                            Spacer()
                            Stepper("\(repeatCount)", value: $repeatCount, in: 1...10)
                        }
                        
                        Picker("Ticking Sound", selection: $selectedTickingSound) {
                            ForEach(tickingSounds, id: \.self) { sound in
                                Text(sound)
                            }
                        }
                        Slider(value: $tickingVolume, in: 0...100, step: 1)
                    }
                    
                    Section(header: Text("THEME")) {
                        Picker("Color Themes", selection: $colorTheme) {
                            ForEach(colorThemes, id: \.self) { theme in
                                Text(theme)
                            }
                        }
                        Toggle("Dark Mode when running", isOn: $isDarkMode)
                    }
                    
                    Section(header: Text("NOTIFICATION")) {
                        Picker("Reminder", selection: $reminder) {
                            ForEach(reminderOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                        HStack {
                            Text("Reminder Time")
                            Spacer()
                            Stepper("\(reminderTime) min", value: $reminderTime, in: 1...60)
                        }
                    }
                }
                .navigationBarTitle("SETTING", displayMode: .inline)
                .navigationBarItems(leading: Button("Cancel", action: { isPresented = false }),
                                    trailing: Button("Save", action: { saveSettings() }))
            }
        }
    }
    
    func saveSettings() {
        // Implement the save action
        isPresented = false
    }
}
#Preview {
    SettingsView(isPresented: .constant(true),pomodoroTime: .constant(25),shortBreakTime: .constant(5),longBreakTime: .constant(15))
}
