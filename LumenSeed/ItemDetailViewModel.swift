//
//  ItemDetailViewModel.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/9/24.
//

import Foundation
class ItemDetailViewModel: ObservableObject {
    @Published var shouldNavigate = false
    var item: GardenItem
    
    init(item: GardenItem) {
        self.item = item
    }
    
    func addItemToCart() {
        // Assume some logic to add item to cart
        self.shouldNavigate = true  // Trigger navigation after adding item
    }
}
