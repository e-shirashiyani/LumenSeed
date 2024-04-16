//
//  BlacklistDetailView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/9/24.
//

import SwiftUI

import SwiftUI

struct BlacklistDetailView: View {
    var appName: String
    @State private var setTimeSwitch: Bool = false
    @State private var downtimeSwitch: Bool = false
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    
    @State private var selectedStartTime: Date = Date()
    @State private var selectedEndedTime: Date = Date()
    @State private var selectedCountDownTime: TimeInterval = 0 // seconds

    @State private var showCountDownTimePicker: Bool = false
    @State private var showStartTimePicker: Bool = false
    @State private var showEndTimePicker: Bool = false


    
    var body: some View {
        VStack {
            
            Text(appName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            Toggle(isOn: $setTimeSwitch) {
                Text("Set times")
            }
            .padding()
            .toggleStyle(SwitchToggleStyle(tint: .red))
            
            if setTimeSwitch {
                VStack {
                    VStack {
                        Text("set Start Time")
                            .foregroundStyle(AppColors.secondry)
                            .font(.subheadline)
                        HStack {
                            Text(selectedStartTime, style: .time)
                                .font(.system(size: 40, weight: .bold))
                                
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: 120)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(color: .gray, radius: 4, x: 0, y: 0.5)
                    .padding(.horizontal)
                    .onTapGesture {
                        showStartTimePicker = true
                    }
                    
                    VStack {
                        Text("set End Time")
                            .foregroundStyle(AppColors.secondry)
                            .font(.subheadline)
                        HStack {
                            Text(selectedEndedTime, style: .time)
                                .font(.system(size: 40, weight: .bold))
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: 120)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
                    .padding(.horizontal)
                    .padding(.top,30)
                    .onTapGesture {
                        showEndTimePicker = true
                    }
                }
            }

            
            
            Toggle(isOn: $downtimeSwitch) {
                Text("Downtime Reminders")
            }
            .padding()
            .toggleStyle(SwitchToggleStyle(tint: .red))
            
            if downtimeSwitch {
                VStack {
                    VStack {
                        Text("set Time")
                            .foregroundStyle(AppColors.secondry)
                            .font(.subheadline)
//                            .padding(.all,0.1)
                        Text(formatTimeInterval(selectedCountDownTime))
                            .font(.system(size: 50,weight: .bold))

                    }
                    .frame(maxWidth: .infinity,maxHeight: 120)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(color: .gray, radius: 4, x: 0, y: 0.5)
                    .padding(.horizontal)
                    .onTapGesture {
                        showCountDownTimePicker = true
                        }
                    
                }
            }
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Blacklist details")
        .navigationBarTitleDisplayMode(.inline)
        
        .sheet(isPresented: $showCountDownTimePicker) {
            CountDownTimePickerView(selectedTime: $selectedCountDownTime, isPresented: $showCountDownTimePicker)
        }
        .sheet(isPresented: $showStartTimePicker) {
            TimePickerView(isPresented: $showStartTimePicker, selectedTime: $selectedStartTime)
                }
        .sheet(isPresented: $showEndTimePicker) {
            TimePickerView(isPresented: $showEndTimePicker, selectedTime: $selectedEndedTime)
                }
    }
}
func formatTimeInterval(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        return String(format: "%02d:%02d", hours, minutes)
    }

#Preview {
    BlacklistDetailView(appName: "Facebook")
}
