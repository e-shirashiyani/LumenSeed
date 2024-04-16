//
//  FocusView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI
import AVFoundation

struct FocusView: View {
    @State private var selectedTimer: Int = 25 * 60
    @State private var isActive: Bool = false
    @State private var showingAddTaskSheet = false
    @State private var estimatedPomodoros = 1
    @State private var tasks: [Task] = []
    @State private var showingSettings = false
    @State private var pomodoroTime: Int = 25 * 60
    @State private var shortBreakTime: Int = 5 * 60
    @State private var longBreakTime: Int = 15 * 60
    @State private var timeRemaining: Int?
    @State private var selectedTimerType: String = "Pomo"
    @State private var audioPlayer: AVAudioPlayer?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var timerTypes: [(String, Int)] {
        [
            ("Pomo", pomodoroTime),
            ("Short", shortBreakTime),
            ("Long", longBreakTime)
        ]
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    HStack(spacing: 16) {
                        Spacer()
                        
                        Button(action: {
                            showingSettings.toggle()
                            // Perform an action for the third button
                        }) {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 35,height: 35)
                                .foregroundStyle(.secondry)
                        }
                        .sheet(isPresented: $showingSettings) {
                            SettingsView(
                                isPresented: $showingSettings,
                                pomodoroTime: $pomodoroTime,
                                shortBreakTime: $shortBreakTime,
                                longBreakTime: $longBreakTime
                            )
                        }
                        
                        Button(action: {
                            // Perform an action for the fourth button (profile image)
                        }) {
                            Image("profileImage")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        }
                    }
                    HStack {
                        ForEach(0..<timerTypes.count, id: \.self) { index in
                            Button(action: {
                                self.selectedTimer = self.timerTypes[index].1
                                self.selectedTimerType = self.timerTypes[index].0
                                self.timeRemaining = self.timerTypes[index].1
                            }) {
                                Text(self.timerTypes[index].0)
                                    .padding(.all,10)
                                    .background(self.selectedTimer == self.timerTypes[index].1 ? AppColors.primary : Color.gray.opacity(0.2))
                                
                                    .foregroundColor(self.selectedTimer == self.timerTypes[index].1 ? Color.white : AppColors.secondry)
                            }
                            .cornerRadius(6)
                        }
                    }
                    .padding(.top,30)
                    
                    Text(timeString(time: timeRemaining ?? selectedTimer))
                        .font(.system(size: 90))
                        .fontWeight(.medium)
                        .foregroundStyle(AppColors.secondry)
                        .padding()
                        .padding(.top)
                    
                    Button(action: {
                        self.startTimer()
                    }) {
                        Text(isActive ? "STOP" : "START")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 60)
                            .font(.system(size: 28))
                            .background(AppColors.primary)
                            .cornerRadius(6)
                    }
                    .padding(.top)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("#\(estimatedPomodoros)\nTime to focus!")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .padding()
                    
                    
                    Button(action: {
                        self.showingAddTaskSheet = true
                        
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundStyle(AppColors.primary)
                                .font(.title)
                            
                            Text("Add Task")
                                .font(.title2)
                                .frame(alignment: .center)
                                .foregroundStyle(AppColors.primary)
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: 50)
                    .background(AppColors.secondry.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.top,40)
                    .padding(.all,8)
                    .sheet(isPresented: $showingAddTaskSheet) {
                        AddTaskSheetView(estimatedPomodoros: $estimatedPomodoros, tasks: $tasks)
                    }
                    
                    
                    List {
                        ForEach(tasks) { task in
                            TaskCardView(task: task)
                        }
                        .onDelete(perform: deleteTask)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
                .padding()
            }
        } 
        .onReceive(timer) { _ in
            guard isActive, let remaining = timeRemaining, remaining > 0 else { return }
            self.timeRemaining! -= 1
            if self.timeRemaining! <= 0 {
                self.isActive = false
                self.timeRemaining = nil
                playSound()
            }
        }
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func startTimer() {
           if isActive {
               // Stop the timer and reset the remaining time
               isActive = false
               timeRemaining = nil
           } else {
               // Start the timer based on selected type
               switch selectedTimerType {
               case "Pomo":
                   timeRemaining = pomodoroTime
               case "Short":
                   timeRemaining = shortBreakTime
               case "Long":
                   timeRemaining = longBreakTime
               default:
                   break
               }
               isActive = true  // Start the timer
           }
       }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "bell", withExtension: "wav") else {
            print("Sound file not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 1.0 
            audioPlayer?.play()
            
            // Stop the sound after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.audioPlayer?.stop()
            }
        } catch {
            print("Could not load sound file: \(error)")
        }
    }
}


#Preview {
    FocusView()
}
