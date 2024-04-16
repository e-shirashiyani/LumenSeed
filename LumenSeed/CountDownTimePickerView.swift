//
//  TimePickerView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/11/24.
//

import SwiftUI

struct CountDownTimePickerView: View {
    @Binding var selectedTime: TimeInterval
        @State private var hours: Int = 0
        @State private var minutes: Int = 0
    @Binding var isPresented: Bool

        let maxHours = 23
        let maxMinutes = 59

        var body: some View {
            VStack {
                
                Text("Select an hour")
                    .font(.title2)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .background(AppColors.primary)
                
                Picker("Hours", selection: $hours) {
                    ForEach(0...maxHours, id: \.self) { hour in
                        Text("\(hour) hours").tag(hour)
                    }
                }
                
                .onChange(of: hours) { newHours in
                    // Update selectedTime when hours change
                    selectedTime = TimeInterval(newHours * 3600 + minutes * 60)
                }
                

                Text("Select a minute")
                    .font(.title2)
//                    .padding(.top,30)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .background(AppColors.primary)

                Picker("Minutes", selection: $minutes) {
                    ForEach(0...maxMinutes, id: \.self) { minute in
                        Text("\(minute) minutes").tag(minute)
                    }
                }
                .onChange(of: minutes) { newMinutes in
                    selectedTime = TimeInterval(hours * 3600 + newMinutes * 60)
                }
                
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                         .foregroundColor(AppColors.secondry)
                         .frame(height: 5)
                         .frame(width: 100)
                         .padding()
//                         .background(AppColors.secondry)
                         .cornerRadius(25)
                    }

                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Okay")
                         .foregroundColor(.white)
                         .frame(height: 5)
                         .frame(width: 100)
                         .padding()
                         .background(AppColors.primary)
                         .cornerRadius(25)
                    }
                }
                .padding(.top,60)
            }
            .pickerStyle(WheelPickerStyle())
            
            .onAppear {
                // Convert selectedTime to hours and minutes
                hours = Int(selectedTime) / 3600
                minutes = Int(selectedTime) % 3600 / 60
            }
            Spacer()

        }
}
#Preview {
    CountDownTimePickerView(selectedTime: .constant(3600), isPresented: .constant(true))
}
