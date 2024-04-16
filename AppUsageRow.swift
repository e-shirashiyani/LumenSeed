//
//  AppUsageRow.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/11/24.
//

import SwiftUI

struct AppUsageRow: View {
    var appName: String
    var usageTime: String

    var body: some View {
        HStack {
            Text(appName)
                .font(.headline)
            Spacer()
            VStack(alignment: .trailing,spacing: 0) {
                Text(usageTime)
                    .font(.subheadline)
                    .foregroundStyle(AppColors.primary)
                    .fontWeight(.bold)
                    .frame(alignment: .trailing)
                ProgressView(value: 60, total: 120)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 200)
                    .tint(AppColors.primary)
                    
//                    .preferredColorScheme(.)
            }
            
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    AppUsageRow(appName: "Facebook", usageTime: "1h 23m")
}
