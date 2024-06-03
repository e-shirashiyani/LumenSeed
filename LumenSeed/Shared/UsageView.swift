//
//  UsageView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/11/24.
//

import SwiftUI

struct UsageView: View {
    @State private var selectedPeriod: UsagePeriod = .today
        @State private var appUsages: [AppUsage] = [
            AppUsage(appName: "Reddit", usageTimes: [60, 120, 180]), 
            AppUsage(appName: "Facebook", usageTimes: [60, 120, 180]),
            AppUsage(appName: "Messenger", usageTimes: [60, 120, 180]),
            AppUsage(appName: "Snapchat", usageTimes: [60, 120, 180])
        ]
    var body: some View {
        ScrollView {
            VStack {
                Text("Usage")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
                HStack (spacing: 20) {
                    
                    VStack {
                        Text("Today's usage")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(AppColors.primary)
                        
                        HStack(alignment: .bottom,spacing: 3) {
                            Text("93")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("min")
                                .font(.title3)
                                .padding(.bottom,4)
                        }
                        
                        Image("clock")
                            .resizable()
                            .scaledToFit()
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 5))
                    
                    VStack {
                        Text("Daily usage goal")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(AppColors.primary)
                        
                        HStack(alignment: .bottom,spacing: 5) {
                            Text("70")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("min")
                                .font(.title3)
                                .padding(.bottom,4)
                        }
                        Image("iphone")
                            .resizable()
                            .scaledToFit()
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 5))
                    
                }
                .padding()
                
                Text("Your most used apps")
                    .font(.title2)
                    .padding(.vertical)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity,alignment: .center)
                    
                PeriodPicker(selectedPeriod: $selectedPeriod)
                    ForEach(appUsages, id: \.appName) { usage in
                                AppUsageRow(appName: usage.appName, usageTime: usage.formattedTime(for: selectedPeriod))
                        }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
            }
        }
    }
}

enum UsagePeriod: String, CaseIterable {
    case today = "Today"
    case thisWeek = "This Week"
    case thisMonth = "This Month"
}

struct PeriodPicker: View {
    @Binding var selectedPeriod: UsagePeriod
    let periods = UsagePeriod.allCases

    var body: some View {
        HStack() {
            ForEach(periods, id: \.self) { period in
                VStack(spacing: 5) {
                    Text(period.rawValue)
                        .fontWeight(selectedPeriod == period ? .bold : .regular)
                        .foregroundStyle(selectedPeriod == period ? .black : .secondary)
//                        .frame(alignment: .leading)
                    
                    // Red circle indicator
                    if selectedPeriod == period {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(AppColors.primary)
                    } else {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color.clear)
                    }
                }
                .padding(.bottom,30)
                .onTapGesture {
                    withAnimation {
                        selectedPeriod = period
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .animation(.default, value: selectedPeriod)
    }
}
struct AppUsage {
    var appName: String
    var usageTimes: [Int]  // Indexed by UsagePeriod in order: today, this week, this month
    
    func formattedTime(for period: UsagePeriod) -> String {
        let timeIndex = UsagePeriod.allCases.firstIndex(of: period) ?? 0
        let time = usageTimes[timeIndex]
        // Format the time as needed, e.g., into hours and minutes
        return "\(time / 60)h \(time % 60)m"
    }
}
#Preview {
    UsageView()
}
