//
//  Share.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation

class Share: Item {
    
    var quantityToShare: Int
    var quantityToClaim: Int
    
    init(quantityToShare: Int, quantityToClaim: Int, name: String, quantity: Int, image: String, price: Int, note: String, registDate: Date, expiredDate: Date) {
        self.quantityToClaim = quantityToShare
        self.quantityToShare = quantityToShare
        super.init(name: name, quantity: quantity, image: image, price: price, note: note, registDate: registDate, expiredDate: expiredDate)
    }
    
    
    func getQuantityToShare() -> Int {
        return quantityToShare
    }
    func getQuantityToClaim() -> Int {
        return quantityToClaim
    }
    func setQuantityToShare(quantity: Int) {
        self.quantityToShare = quantity
    }
    func setQuantityToClaim(quantity: Int) {
        self.quantityToClaim = quantity
    }
    
}
