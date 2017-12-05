//
//  User.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation

class User{
    var name: String
    var password: String
    var address: String
    var id: String
    
    init(name: String, password:String, address: String, id: String) {
        self.name = name
        self.password = password
        self.address = address
        self.id = id
        
    }
    func getName() -> String {
        return name
    }
    func getPassword() -> String {
        return password
    }
    func getAddress() -> String {
        return address
    }
    func getId() -> String {
        return id
    }
    
    func setName(name: String) {
        self.name = name
    }
    func setAddress(address: String) {
        self.address = address
    }
    func setPassword(password: String) {
        self.password = password
    }
    func setId(id: String) {
        self.id = id
    }
    
    
}
