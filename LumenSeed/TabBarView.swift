//
//  TabBarView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/3/24.
//

import SwiftUI

struct TabBarView: View {
        @State private var selectedTab = 1
            var body: some View {
                
                TabView(selection: $selectedTab) {
                    
                    TimeLineView()
                        .tabItem {
                            Label("timeline", systemImage: "list.bullet")
                        }
                        .tag(1)

                    FocusView()
                        .tabItem {
                            Label("timer", systemImage: "timer")
                        }
                        .tag(2)

                    GardenView()
                        .tabItem {
                            Label("Garden", systemImage: "leaf.fill")
                        }
                        .tag(3)

                    BlacklistView()
                        .tabItem {
                            Label("blacklist", systemImage: "nosign")
                        }
                        .tag(4)

                    UsageView()
                        .tabItem {
                            Label("usage", systemImage: "chart.bar.xaxis")
                        }
                        .tag(5)
                }
                
                .tint(AppColors.primary)
                .preferredColorScheme(.light)
            }
    
}

#Preview {
    TabBarView()
}
