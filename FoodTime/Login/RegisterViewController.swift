//
//  RegisterViewController.swift
//  FoodTime
//
//  Created by Liana Ester Wulandari on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class RegisterViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var userUid : String!
    
    @IBAction func buttonRegister(_ sender: Any) {
        if let email = email.text, let password = password.text, let username = textFieldUserName.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                if error != nil {
                    print("Cant create user")
                } else {
                    if let user = user {
                        self.userUid = user.uid
                        self.performSegue(withIdentifier: "toMessages", sender: nil)
                    }
                }
            })
        }
    }
    
    @IBOutlet weak var labelColor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelColor.layer.cornerRadius = 30
        labelColor.layer.borderWidth = 5
        labelColor.layer.borderColor = UIColor.white.cgColor
        labelColor.clipsToBounds = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }
    
    @IBAction func cancel (_ sender: AnyObject){
        dismiss(animated: true, completion: nil)
    }
    
}

