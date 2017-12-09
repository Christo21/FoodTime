//
//  ChatViewController.swift
//  FoodTime
//
//  Created by Liana Ester Wulandari on 06/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messageDetail = [MessageDetail]()
    var detail : MessageDetail!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    var recipient: String!
    var messageId: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        /*
        Database.database().reference().child("users").child(currentUser!).child("messages").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                self.messageDetail.removeAll()
                for data in snapshot {
                    if let messageDict = data.value as? Dictionary<String, AnyObject> {
                        let key = data.key
                        let info = MessageDetail(messageKey: key, messageData: messageDict)
                        self.messageDetail.append(info)
                    }
                }
            }
            self.tableView.reloadData()
        })
        */
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageDet = messageDetail[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? messageDetailTableViewCell {
            cell.configureCell(messageDetail: messageDet)
            return cell
        }
        else {
            return messageDetailTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipient = messageDetail[indexPath.row].recipient
        messageId = messageDetail[indexPath.row].messageReg.key
        performSegue(withIdentifier: "toMessages", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewContoller = segue.destination as? MessageViewController {
            destinationViewContoller.recipient = recipient
            destinationViewContoller.messageId = messageId
        }
    }
    @IBAction func signOut (_ sender: AnyObject){
        try! Auth.auth().signOut()
        KeychainWrapper.standard.removeObject(forKey:  "uid")
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

