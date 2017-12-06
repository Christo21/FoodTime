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
    
    init(quantityToShare: Int, quantityToClaim: Int, idItem: String, name: String, type: String, quantity: Int, image: String, price: String, note: String, registDate: String, expiredDate: String) {
        self.quantityToClaim = quantityToShare
        self.quantityToShare = quantityToShare
        super.init(idItem: idItem, name: name, type: type, quantity: quantity, image: image, price: price, note: note, registDate: registDate, expiredDate: expiredDate)
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
