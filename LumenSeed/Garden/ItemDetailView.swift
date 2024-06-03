//
//  ItemDetailView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/8/24.
//

import SwiftUI

import SwiftUI

struct ItemDetailView: View {
    var userPoints: Int = 120
    var item: GardenItem
    @State private var showSuccessView = false
    @ObservedObject var viewModel: ItemDetailViewModel

    var body: some View {
        HStack {
            Spacer()
            
            PointsView(points: 10)
                .padding(.trailing)
        }
        NavigationStack {

            VStack() {
               
                
                Spacer()
                
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .clipped()
                    .frame(alignment: .center)
                
                Spacer()
                
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top,20)
                    .padding(.leading,20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(item.description)
                    .padding([.leading, .trailing, .bottom])
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .padding(.top,6)
                    .lineSpacing(10)
                
                Spacer()
                
                Button(action: {
                    viewModel.addItemToCart()

                }) {
                    HStack {
                        Text("Add item")
                            .fontWeight(.bold)
                        Text("| \(item.points) points")
                    }
                    .foregroundColor(.white)
                    .frame(width: 230)
                    .padding()
                    .background(AppColors.primary)
                    .clipShape(.capsule, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .background(NavigationLink(destination: SuccessView(), isActive:  $viewModel.shouldNavigate) {
                                    EmptyView()
                                })
                .navigationBarHidden(false)
//                .toolbar(.hidden, for: .tabBar)
               
            }
        }
    }
}

#Preview {
    ItemDetailView(item: GardenItem(name: "Watering pail", points: 30, imageName: "plant3", description: "The snake plant is also known as Saint George’s sword, mother-in-law’s tongue or viper’s bow hemp."), viewModel: ItemDetailViewModel(item: GardenItem(name: "Watering pail", points: 30, imageName: "plant3", description: "The snake plant is also known as Saint George’s sword, mother-in-law’s tongue or viper’s bow hemp.")))
}
