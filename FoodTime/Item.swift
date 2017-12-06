//
//  Item.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation

class Item{
    var idItem: String
    var name: String
    var type: String
    var quantity: Int
    var image: String
    var price: String
    var note: String
    var registDate: Date!
    var expiredDate: Date!
    
    init(idItem: String, name: String, type: String, quantity: Int, image: String, price: String, note: String, registDate: String, expiredDate: String) {
        self.idItem = idItem
        self.name = name
        self.type = type
        self.quantity = quantity
        self.image = image
        self.price = price
        self.note = note
        self.setRegistDate(registDate: registDate)
        self.setExpiredDate(expiredDate: expiredDate)
    }
    
    private func stringToDate(dt: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(dt)
        let date = dateFormatter.date(from: dt)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        return calendar.date(from:components)!
    }
    
    //getter
    func getIdItem() -> String {
        return idItem
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
    func getPrice() -> String {
        return price
    }
    func getNote() -> String {
        return note
    }
    func getRegistDate() -> Date {
        return registDate
    }
    func getExipredDate() -> Date {
        return expiredDate
    }
    
    //setter
    func setIdItem(idItem: String) {
        self.idItem = idItem
    }
    func setName(name: String) {
        self.name = name
    }
    func setType(type: String) {
        self.type = type
    }
    func setQuantity(quantity: Int) {
        self.quantity = quantity
    }
    func setImage(image: String) {
        self.image = image
    }
    func setPrice(price: String) {
        self.price = price
    }
    func setNote(note: String) {
        self.note = note
    }
    func setRegistDate(registDate: Date) {
        self.registDate = registDate
    }
    func setRegistDate(registDate: String) {
        self.registDate = stringToDate(dt: registDate)
    }
    func setExpiredDate(expiredDate:Date) {
        self.expiredDate = expiredDate
    }
    func setExpiredDate(expiredDate:String) {
        self.expiredDate = stringToDate(dt: expiredDate)
    }
    
    
}
