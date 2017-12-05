//
//  Item.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation

class Item{
    var name: String
    var type: String
    var quantity: Int
    var image: String
    var note: String
    var registDate: String
    var expiredDate: String
    
    init(name: String, type: String, quantity: Int, image: String, note: String, registDate: String, expiredDate: String) {
        self.name = name
        self.type = type
        self.quantity = quantity
        self.image = image
        self.note = note
        self.registDate = registDate
        self.expiredDate = expiredDate
    }
    
    func getName() -> String {
        return name
    }
    func getType() -> String {
        return type
    }
    func getQuantity() -> Int {
        return quantity
    }
    func getImage() -> String {
        return image
    }
    func getNote() -> String {
        return note
    }
    func getRegistDate() -> String {
        return registDate
    }
    func getExipredDate() -> String {
        return expiredDate
    }
    
    //setter
    func setName(name: String) {
        self.name = name
    }
    func setType(type: String) {
        self.type = type
    }
    func setQuantity(quantity: Int) {
        self.quantity = quantity
    }
    func setNote(note: String) {
        self.note = note
    }
    func setImage(image: String) {
        self.image = image
    }
    func setRegistDate(registDate: String) {
        self.registDate = registDate
    }
    func setExpiredDate(expiredDate:String) {
        self.expiredDate = expiredDate
    }
    
    
}
