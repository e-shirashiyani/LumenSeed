//
//  GardenView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/6/24.
//

import SwiftUI

import SwiftUI

// Model for the garden item
struct GardenItem: Identifiable {
    let id = UUID()
    let name: String
    let points: Int
    let imageName: String
    let description: String
}

// Sample data for the grid
let gardenItems = [
    GardenItem(name: "Watering pail", points: 30, imageName: "plant1", description: "The snake plant is also known as Saint George’s sword, mother-in-law’s tongue or viper’s bow hemp."),
    GardenItem(name: "Pink flamingo", points: 50, imageName: "plant2", description: "The snake plant is also known as Saint George’s sword, mother-in-law’s tongue or viper’s bow hemp."),
    GardenItem(name: "Cacti planter", points: 70, imageName: "plant3", description: "The snake plant is also known as Saint George’s sword, mother-in-law’s tongue or viper’s bow hemp."),
    GardenItem(name: "Snake plant", points: 90, imageName: "plant4", description: "The snake plant is also known as Saint George’s sword, mother-in-law’s tongue or viper’s bow hemp.")
]

struct GardenView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(gardenItems) { item in
                        NavigationLink(destination: ItemDetailView(item: item, viewModel: ItemDetailViewModel(item: item))) {
                            GardenItemView(item: item)
                        }
                    }
                    .navigationTitle("Garden")
                }
                .padding()
            }
        }
    }
}

struct GardenItemView: View {
    let item: GardenItem

    var body: some View {
        VStack {
            Image(item.imageName) // Replace with the actual images
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)

            Text(item.name)
                .font(.headline)
                .foregroundColor(.primary)

            Text("\(item.points) Points")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button(action: {
                // Handle the add action
            }) {
                Text("Add")
                 .foregroundColor(.white)
                 .frame(height: 5)
                 .frame(width: 40)
                 .padding()
                
                 .background(AppColors.primary)
                 .cornerRadius(25)
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onAppear {
                       UITabBar.appearance().isHidden = false
                   }
    }
}
#Preview {
    GardenView()
}
