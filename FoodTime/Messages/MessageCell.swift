//
//  MessageCell.swift
//  FoodTime
//
//  Created by Petra Pradnya Pramesthi on 10/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MessagesCell: UITableViewCell {
    @IBOutlet weak var receivedMessagesLbl: UILabel!
    @IBOutlet weak var receivedMessageView: UIView!
    @IBOutlet weak var sentMessageLbl: UILabel!
    @IBOutlet weak var sentMessageView: UIView!
    
    var message: Message!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    func configCell(message: Message) {
        self.message = message
        if message.sender == currentUser {
            sentMessageView.isHidden = false
            sentMessageLbl.text = message.message
            receivedMessagesLbl.text = ""
            receivedMessagesLbl.isHidden = true
            
        } else {
            sentMessageView.isHidden = true
            sentMessageLbl.text = ""
            receivedMessagesLbl.text = message.message
            receivedMessagesLbl.isHidden = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

