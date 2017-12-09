//
//  itemDataList.swift
//  FoodTime
//
//  Created by Petra Pradnya Pramesthi on 09/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation

class itemDataList {
    
    var itemDataList: [itemData] = []
    
    class itemData {
        var name: String!
        var expiredDays: Int!
        
        init(name: String, expiredDays: Int) {
            self.name = name
            self.expiredDays = expiredDays
        }
        
        func getName() -> String {
            return name
        }
        func getExpiredDays() -> Int {
            return expiredDays
        }
    }
    
    func getItemDataList() -> [itemData] {
        return itemDataList
    }
    
    init() {
        itemDataList.append(itemData(name: "Apples", expiredDays: 7))
        itemDataList.append(itemData(name: "Almonds", expiredDays: 60))
        itemDataList.append(itemData(name: "Asparagus", expiredDays: 3))
        itemDataList.append(itemData(name: "Avocado", expiredDays: 5))
        itemDataList.append(itemData(name: "Bacon", expiredDays: 15))
        itemDataList.append(itemData(name: "Banana", expiredDays: 6))
        itemDataList.append(itemData(name: "Basil", expiredDays: 5))
        itemDataList.append(itemData(name: "Beef", expiredDays: 4))
        itemDataList.append(itemData(name: "Biscuits", expiredDays: 60))
        itemDataList.append(itemData(name: "Black peper", expiredDays: 60))
        itemDataList.append(itemData(name: "Blueberries", expiredDays: 4))
        itemDataList.append(itemData(name: "Bread", expiredDays: 7))
        itemDataList.append(itemData(name: "Brocoli", expiredDays: 7))
        itemDataList.append(itemData(name: "Buns", expiredDays: 7))
        itemDataList.append(itemData(name: "Butter", expiredDays: 30))
        itemDataList.append(itemData(name: "Candy", expiredDays: 60))
        itemDataList.append(itemData(name: "Carrots", expiredDays: 14))
        itemDataList.append(itemData(name: "Cheese", expiredDays: 15))
        itemDataList.append(itemData(name: "Chicken", expiredDays: 5))
        itemDataList.append(itemData(name: "Chili", expiredDays: 3))
        itemDataList.append(itemData(name: "Chocolate", expiredDays: 30))
        itemDataList.append(itemData(name: "Coffee", expiredDays: 30))
        itemDataList.append(itemData(name: "Cola", expiredDays: 150))
        itemDataList.append(itemData(name: "Corn", expiredDays: 180))
        itemDataList.append(itemData(name: "Cornflakes", expiredDays: 60))
        itemDataList.append(itemData(name: "Cucumber", expiredDays: 5))
        itemDataList.append(itemData(name: "Eggs", expiredDays: 30))
        itemDataList.append(itemData(name: "Fish", expiredDays: 10))
        itemDataList.append(itemData(name: "Flour", expiredDays: 60))
        itemDataList.append(itemData(name: "Garlic", expiredDays: 120))
        itemDataList.append(itemData(name: "Grapes", expiredDays: 30))
        itemDataList.append(itemData(name: "Ketchup", expiredDays: 30))
        itemDataList.append(itemData(name: "Kiwi", expiredDays: 7))
        itemDataList.append(itemData(name: "Lemon", expiredDays: 30))
        itemDataList.append(itemData(name: "Lettuce", expiredDays: 7))
        itemDataList.append(itemData(name: "Limes", expiredDays: 20))
        itemDataList.append(itemData(name: "Mayonnaise", expiredDays: 30))
        itemDataList.append(itemData(name: "Mushrooms", expiredDays: 4))
        itemDataList.append(itemData(name: "Onions", expiredDays: 150))
        itemDataList.append(itemData(name: "Oranges", expiredDays: 7))
        itemDataList.append(itemData(name: "Peanuts", expiredDays: 60))
        itemDataList.append(itemData(name: "Pears", expiredDays: 7))
        itemDataList.append(itemData(name: "Pineapple", expiredDays: 7))
        itemDataList.append(itemData(name: "Pork", expiredDays: 15))
        itemDataList.append(itemData(name: "Potatoes", expiredDays: 7))
        itemDataList.append(itemData(name: "Red Onions", expiredDays: 30))
        itemDataList.append(itemData(name: "Salt", expiredDays: 60))
        itemDataList.append(itemData(name: "Shrimps", expiredDays: 5))
        itemDataList.append(itemData(name: "Spinach", expiredDays: 6))
        itemDataList.append(itemData(name: "Strawberries", expiredDays: 4))
        itemDataList.append(itemData(name: "Sugar", expiredDays: 180))
        itemDataList.append(itemData(name: "Tea", expiredDays: 60))
        itemDataList.append(itemData(name: "Tomatoes", expiredDays: 4))
        itemDataList.append(itemData(name: "Watermelon", expiredDays: 18))
        itemDataList.append(itemData(name: "Yogurt", expiredDays: 8))
    }
    
}
