//
//  Item.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation
import CoreData

class Item{
    var name: String
    var quantity: Int
    var image: String
    var price: Int
    var note: String
    var registDate: Date!
    var expiredDate: Date!
    
    init(name: String, quantity: Int, image: String, price: Int, note: String, registDate: Date, expiredDate: Date) {
        self.name = name
        self.quantity = quantity
        self.image = image
        self.price = price
        self.note = note
        self.setRegistDate(registDate: registDate)
        self.setExpiredDate(expiredDate: expiredDate)
    }
    init(name: String, quantity: Int, image: String, price: Int, note: String, registDate: String, expiredDate: String) {
        self.name = name
        self.quantity = quantity
        self.image = image
        self.price = price
        self.note = note
        self.setRegistDate(registDate: registDate)
        self.setExpiredDate(expiredDate: expiredDate)
    }
    init(item: NSManagedObject) {
        self.name = item.value(forKey: "name")! as! String
        self.quantity = item.value(forKey: "quantity")! as! Int
        self.image = item.value(forKey: "image")! as! String
        self.price = item.value(forKey: "price")! as! Int
        self.note = item.value(forKey: "note")! as! String
        self.setRegistDate(registDate: item.value(forKey: "registDate") as! Date)
        self.setExpiredDate(expiredDate: item.value(forKey: "expiredDate") as! Date)
    }
    
    private func stringToDate(dt: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        print(dt)
        let date = dateFormatter.date(from: dt)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        return calendar.date(from:components)!
    }
    
    //getter
    func getName() -> String {
        return name
    }
    func getQuantity() -> Int {
        return quantity
    }
    func getImage() -> String {
        return image
    }
    func getPrice() -> Int {
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
    func setName(name: String) {
        self.name = name
    }
    func setQuantity(quantity: Int) {
        self.quantity = quantity
    }
    func setImage(image: String) {
        self.image = image
    }
    func setPrice(price: Int) {
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
