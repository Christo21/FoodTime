//
//  MessageViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 29/11/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }
    
    @objc func handleLogout(){
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
    }
}
