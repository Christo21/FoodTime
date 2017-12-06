//
//  List.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation

class List: Item {
    var desc: String
    
    init(desc: String, idItem: String, name: String, type: String, quantity: Int, image: String, price: String, note: String, registDate: String, expiredDate: String) {
        self.desc = desc
        super.init(idItem: idItem, name: name, type: type, quantity: quantity, image: image, price: price, note: note, registDate: registDate, expiredDate: expiredDate)
    }
    func getDesc() -> String {
        return desc
    }
    func setDesc(desc: String) {
        self.desc = desc
    }
    
}
