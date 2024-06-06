//
//  LumenSeedApp.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/3/24.
//

import SwiftUI
import SwiftData
import AVFAudio

@main
struct LumenSeedApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    @State private var showLaunchScreen = true

    init() {
        setupAudioSession()

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(named: "black")
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if showLaunchScreen {
                    LaunchScreenView()
                } else {
                    FocusView()
                        .tint(.white)
                        .onAppear(perform: setupLifecycleObserver)
                        .preferredColorScheme(.light)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.showLaunchScreen = false
                    }
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }

    func setupLifecycleObserver() {
        NotificationCenter.default.addObserver(forName: UIScene.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
            print("Moving to the background!")
        }

        NotificationCenter.default.addObserver(forName: UIScene.willEnterForegroundNotification, object: nil, queue: .main) { _ in
            print("Back to the foreground!")
            cancelNotification()
        }
    }
}
