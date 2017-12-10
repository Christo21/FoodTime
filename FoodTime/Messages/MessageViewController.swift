//
//  MessageViewController.swift
//  FoodTime
//
//  Created by Petra Pradnya Pramesthi on 10/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var sharedImage: UIImage!
    var sharedName: String = ""
    var note: String = ""
    var messages = [Message]()
    var message: Message!
    var messageId: String!
    var recipient: String!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    @IBOutlet weak var claimBackground: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var imageClaim: UIImageView!
    @IBOutlet weak var nameClaim: UILabel!
    @IBOutlet weak var noteClaim: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func camera(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet weak var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        claimBackground.layer.borderWidth = 1
        claimBackground.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        claimBackground.layer.cornerRadius = 8
        
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cancelButton.layer.cornerRadius = 8
        
        okButton.layer.borderWidth = 1
        okButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        okButton.layer.cornerRadius = 8
        
        imageClaim.image = sharedImage
        nameClaim.text = sharedName
        noteClaim.text = note
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 300

        
        if messageId != "" && messageId != nil{
            loadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.moveToButtom()
        }
        
    }
    
    func loadData(){
        print("MASUK")
        Database.database().reference().child("messages").child(messageId).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                self.messages.removeAll()
                for data in snapshot {
                    if let postDict = data.value as? Dictionary<String, AnyObject> {
                        let key = data.key
                        let post = Message(messageKey: key, postData: postDict)
                        self.messages.append(post)
                    }
                }
            }
            self.messageTableView.reloadData()
        })
    }
    
    @objc func keyboardWillShow(notify: NSNotification){
        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notify: NSNotification){
        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc override func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Message") as? MessagesCell {
            cell.configCell(message: message)
            return cell
        }
        else {
            return MessagesCell()
        }
    }
    func moveToButtom(){
        if messages.count > 0 {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    @IBAction func sendButton(_ sender: UIButton) {
        dismissKeyboard()
        if (textField.text != nil && textField.text != ""){
            if messageId != nil {
                let post: Dictionary<String, AnyObject> = [
                    "message": textField.text as AnyObject,
                    "sender": recipient as AnyObject
                ]
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": textField.text as AnyObject,
                    "recipient": recipient as AnyObject
                ]
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": textField.text as AnyObject,
                    "sender": recipient as AnyObject
                ]
                messageId = Database.database().reference().child("messages").childByAutoId().key
                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
                
                firebaseMessage.setValue(post)
                
                let recipientMassage = Database.database().reference().child("users").child(recipient).child("messages").child(messageId)
                
                recipientMassage.setValue(recipientMassage)
                
                
                let  userMassage = Database.database().reference().child("users").child(currentUser!).child("messages").child(messageId)
                
                userMassage.setValue(message)
                loadData()
            } else if messageId != "" {
                let post: Dictionary<String, AnyObject> = [
                    "message": textField.text as AnyObject,
                    "sender": recipient as AnyObject
                ]
                let message: Dictionary<String, AnyObject> = [
                    "lastmessage": textField.text as AnyObject,
                    "recipient": recipient as AnyObject
                ]
                let recipientMessage: Dictionary<String, AnyObject> = [
                    "lastmessage": textField.text as AnyObject,
                    "sender": recipient as AnyObject
                ]
                
                let firebaseMessage = Database.database().reference().child("messages").child(messageId).childByAutoId()
                
                firebaseMessage.setValue(post)
                
                let recipientMassage = Database.database().reference().child("users").child(recipient).child("messages").child(messageId)
                
                recipientMassage.setValue(recipientMassage)
                
                
                let  userMassage = Database.database().reference().child("users").child(currentUser!).child("messages").child(messageId)
                
                userMassage.setValue(message)
                loadData()
            }
            
            textField.text = ""
        }
        moveToButtom()
    }
}
