//
//  User.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation
import MapKit

class User{
    var name: String
    var password: String
    var address: String
    var id: String
    var location: CLLocationManager
    var list: [List]
    var share: [Share]
    //var chatroom: [Chatroom]
    
    init(name: String, password:String, address: String, id: String) {
        self.name = name
        self.password = password
        self.address = address
        self.id = id
        self.location = CLLocationManager()
        self.list = []
        self.share = []
    }
    
    //getter
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
    func getLocation() -> CLLocationManager {
        return location
    }
    func getList() -> [List] {
        return list
    }
    func getShare() -> [Share] {
        return share
    }
    
    //setter
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
    func setLocation(location: CLLocationManager) {
        self.location = location
    }
    
    //addItem
    func addList(list: List) {
        self.list.append(list)
    }
    func addShare(share: Share) {
        self.share.append(share)
    }
    
    //deleteItem
    func deleteList(position: Int) {
        self.list.remove(at: position)
    }
    func deleteShare(position: Int) {
        self.share.remove(at: position)
    }
    
    
}
