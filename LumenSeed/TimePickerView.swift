//
//  TimePickerView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/11/24.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var isPresented: Bool
    @Binding var selectedTime: Date
    
    var body: some View {
        VStack {
            
            Text("Set start time")
                .bold()
                .font(.title)
            
            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .frame(maxHeight: 400)
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(AppColors.secondry)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(40)

                Button("Okay") {
                    isPresented = false
                }
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(AppColors.primary)
                .cornerRadius(40)
            }
            .padding()
            .padding(.horizontal)
        }
    }
}


#Preview {
    TimePickerView(isPresented: .constant(true), selectedTime: .constant(Date()))
}
