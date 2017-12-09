//
//  LoginViewController.swift
//  FoodTime
//
//  Created by Liana Ester Wulandari on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail : UITextField!
    @IBOutlet weak var textFieldPassword : UITextField!
    
    var userUid : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }
    @IBAction func buttonSignUpBawah(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    @IBAction func signIn (_ sender: AnyObject) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            print("\(email) \(password)")
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    self.userUid =  user?.uid
                    KeychainWrapper.standard.set(self.userUid, forKey: "uid")
                    self.performSegue(withIdentifier: "toMessages", sender: nil)
                } else {
                    print("Gagal")
                }
                
            })
            
        }
    }
    
}

