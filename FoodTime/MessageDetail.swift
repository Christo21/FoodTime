//
//  MessageDetail.swift
//  FoodTime
//
//  Created by Liana Ester Wulandari on 06/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageDetail {
    private var _recipient: String!
    private var _messageKey: String!
    private var _messageRef: DatabaseReference!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    var recipient: String {
        return _recipient
    }
    
    var messageKey: String {
        return _messageKey
    }
    var messageReg: DatabaseReference {
        return _messageRef
    }
    init(messageKey: String, messageData: Dictionary <String, AnyObject>) {
        _messageKey = messageKey 
        
        if let recipient = messageData["recipient"] as? String {
            _recipient = recipient
        }
        _messageRef = DatabaseReference().child("recipient").child(_messageKey)
        
    }
}
