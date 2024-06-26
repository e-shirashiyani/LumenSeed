//
//  FocusView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI
import AVFoundation
import CoreData

struct FocusView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TaskEntity.entity(), sortDescriptors: [])
    private var fetchedTasks: FetchedResults<TaskEntity>
    
    @State private var selectedTimer: Int = 25 * 60
    @State private var isActive: Bool = false
    @State private var showingAddTaskSheet = false
    @State private var estimatedPomodoros = 0
    @State private var taskName = "Time to focus!"
    @State private var showingSettings = false
    @State private var pomodoroTime: Int = 25 * 60
    @State private var shortBreakTime: Int = 5 * 60
    @State private var longBreakTime: Int = 15 * 60
    @State private var timeRemaining: Int?
    @State private var selectedTimerType: String = "Pomo"
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showLottieAnimation: Bool = false
    @State private var activeTaskID: UUID?
    @State private var isPaused: Bool = false
    @State private var showPauseButton: Bool = false
    @State private var showContinueAndStopButtons: Bool = false
    @State private var showDeleteConfirmation: Bool = false
    @State private var taskToDelete: TaskEntity? = nil
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
                Color.white.ignoresSafeArea()
                ScrollView {
                    VStack {
                        HStack(spacing: 16) {
                            Spacer()
                            
                            Button(action: {
                                showingSettings.toggle()
                            }) {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundStyle(.lumenSecondary)
                            }
                            .sheet(isPresented: $showingSettings, onDismiss: {
                                if let selectedTimer = timerTypes.first(where: { $0.0 == selectedTimerType })?.1 {
                                    self.selectedTimer = selectedTimer
                                    self.timeRemaining = selectedTimer
                                }
                            }) {
                                SettingsView(
                                    isPresented: $showingSettings,
                                    pomodoroTime: $pomodoroTime,
                                    shortBreakTime: $shortBreakTime,
                                    longBreakTime: $longBreakTime
                                )
                            }
                            
                            Button(action: {
                                
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
                                        .padding(.all, 10)
                                        .background(self.selectedTimer == self.timerTypes[index].1 ? Color.lumenGreen : Color.gray.opacity(0.2))
                                        .foregroundColor(self.selectedTimer == self.timerTypes[index].1 ? Color.white : Color.secondary)
                                }
                                .cornerRadius(6)
                            }
                        }
                        .padding(.top, 30)
                        
                        Text(timeString(time: timeRemaining ?? selectedTimer))
                            .font(.system(size: 90))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.secondary)
                            .padding()
                            .padding(.top)
                        
                        if showPauseButton {
                            Button(action: {
                                self.pauseTimer()
                            }) {
                                Text("PAUSE")
                                    .foregroundColor(.lumenSecondary.opacity(0.8))
                                    .frame(width: 200, height: 60)
                                    .font(.system(size: 28))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.secondary.opacity(0.8), lineWidth: 2)
                                    )
                            }
                        } else if showContinueAndStopButtons {
                            HStack(spacing: 20) {
                                Button(action: {
                                    self.continueTimer()
                                }) {
                                    Text("CONTINUE")
                                        .foregroundColor(Color.white)
                                        .frame(width: 150, height: 60)
                                        .font(.system(size: 26))
                                        .background(Color.lumenGreen)
                                        .cornerRadius(6)
                                }
                                
                                Button(action: {
                                    self.stopTimer()
                                }) {
                                    Text("STOP")
                                        .foregroundColor(Color.white)
                                        .frame(width: 100, height: 60)
                                        .font(.system(size: 26))
                                        .background(Color.secondary.opacity(0.8))
                                        .cornerRadius(6)
                                }
                            }
                        } else {
                            Button(action: {
                                self.startTimer()
                            }) {
                                Text(isActive ? "STOP" : "START")
                                    .foregroundColor(Color.white)
                                    .frame(width: 200, height: 60)
                                    .font(.system(size: 28))
                                    .background(Color.lumenGreen)
                                    .cornerRadius(6)
                            }
                        }
                        Spacer()
                            .frame(height: 20)
                        
                        Text("#\(estimatedPomodoros)\n\(taskName)")
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .padding()
                        
                        Button(action: {
                            self.showingAddTaskSheet = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                    .foregroundStyle(.lumenGreen)
                                    .font(.title)
                                
                                Text("Add Task")
                                    .font(.title2)
                                    .frame(alignment: .center)
                                    .foregroundStyle(.lumenGreen)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.lumenGreen, lineWidth: 2)
                        )
                        .padding(.top, 40)
                        .padding(.all, 8)
                        .padding(.horizontal,6)
                        .sheet(isPresented: $showingAddTaskSheet) {
                            AddTaskSheetView(estimatedPomodoros: $estimatedPomodoros)
                        }
                        
                        VStack(spacing: 10) {
                            ForEach(fetchedTasks) { task in
                                SwipeableTaskCardView(task: task, onDelete: {
                                    self.taskToDelete = task
                                    self.showDeleteConfirmation = true
                                })
                                .padding(.horizontal, 8)
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 1)
                                .overlay(
                                    HStack {
                                        if self.taskName == task.title {
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(maxWidth: 5, maxHeight: .infinity)
                                                .cornerRadius(6)
                                        }
                                        Spacer()
                                    }
                                )
                                .onTapGesture {
                                    self.estimatedPomodoros = Int(task.pomodoroCount)
                                    self.taskName = task.title ?? ""
                                    self.activeTaskID = task.id
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    .padding()
                    
                    HStack(spacing: 40) {
                        HStack {
                            Text("Pomos:")
                                .font(.system(size: 14))
                                .foregroundStyle(.gray)
                            Text("\(fetchedTasks.reduce(0) { $0 + $1.pomodoroDoneCount })/\(fetchedTasks.reduce(0) { $0 + $1.pomodoroCount })")
                                .bold()
                        }
                        HStack {
                            Text("Tasks:")
                                .foregroundStyle(.gray)
                                .font(.system(size: 14))
                            Text("\(fetchedTasks.count)")
                                .bold()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal,26)
                    
                }
                if showLottieAnimation {
                    LottieView(filename: "finish")
                        .frame(width: 200, height: 200)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showLottieAnimation = false
                            }
                        }
                }
            }
        }
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Delete Task"),
                message: Text("Are you sure you want to delete this task?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let task = taskToDelete {
                        viewContext.delete(task)
                        saveContext()
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .onReceive(timer) { _ in
            guard isActive, let remaining = timeRemaining, remaining > 0 else { return }
            self.timeRemaining! -= 1
            if self.timeRemaining! <= 0 {
                self.isActive = false
                self.timeRemaining = nil
                playSound()
                if let activeTaskID = activeTaskID, let task = fetchedTasks.first(where: { $0.id == activeTaskID }) {
                    task.pomodoroDoneCount += 1
                    if task.pomodoroDoneCount >= task.pomodoroCount {
                        self.showLottieAnimation = true
                    }
                    saveContext()
                } else {
                    self.estimatedPomodoros += 1
                    self.showLottieAnimation = true
                }
                self.showPauseButton = false
                self.showContinueAndStopButtons = false
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
            isActive = false
            timeRemaining = nil
            showPauseButton = false
            showContinueAndStopButtons = false
        } else {
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
            isActive = true
            showPauseButton = true
            showContinueAndStopButtons = false
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func pauseTimer() {
        isPaused = true
        isActive = false
        showPauseButton = false
        showContinueAndStopButtons = true
    }
    
    func continueTimer() {
        isPaused = false
        isActive = true
        showPauseButton = true
        showContinueAndStopButtons = false
    }
    
    func stopTimer() {
        isActive = false
        timeRemaining = nil
        showPauseButton = false
        showContinueAndStopButtons = false
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.audioPlayer?.stop()
            }
        } catch {
            print("Could not load")
        }
    }
}
    #Preview {
        FocusView()
    }
