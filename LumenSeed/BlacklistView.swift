//
//  BlacklistView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/9/24.
//

import SwiftUI

import SwiftUI

struct BlacklistView: View {
    @State private var searchText = ""
    
    @State private var appItems: [AppItem] = [
        AppItem(name: "Airbnb", isBlacklisted: false),
        AppItem(name: "Amazon", isBlacklisted: true),
        AppItem(name: "Facebook", isBlacklisted: false),
        AppItem(name: "Instagram", isBlacklisted: false),
        AppItem(name: "Twitter", isBlacklisted: true),
        // Add more items...
    ]
    
    var body: some View {
            NavigationView {
                List($appItems) { $item in
                    NavigationLink(destination: BlacklistDetailView(appName: item.name)) {
                        HStack {
                            Image(systemName: item.isBlacklisted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isBlacklisted ? AppColors.primary : .gray)
                                .onTapGesture {
                                    item.isBlacklisted.toggle() // This toggles the blacklist status
                                }
                            Text(item.name)
                            Spacer()
                            if item.isBlacklisted {
                                Image(systemName: "gearshape.fill")
                            }
                        }
                    }
                }
                .navigationTitle("Blacklist")
                .toolbar {
                            ToolbarItem(placement:.navigationBarTrailing) {
                                Button(action: {
                                    // The action to add a new item
                                    let newItem = AppItem(name: "NewApp", isBlacklisted: false)
                                    appItems.append(newItem)
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(AppColors.secondry)
                                }
                            }
                        }
                .searchable(text: $searchText, prompt: "Search by name")
            }
        }
}

struct AppItem: Identifiable {
    let id = UUID() // UUID() generates a unique identifier
    var name: String
    var isBlacklisted: Bool
}

#Preview {
    BlacklistView()
}
