//
//  LoginController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 29/11/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBAction func cancelLoginButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUp", sender: sender)
    }
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    var userUid : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
        nameField.frame.size.height = 40
        passField.frame.size.height = 40
        hideKeyboardWhenTappedAround()
    }
    
    var user: String = ""
    var pass: String = ""
    
    func validation() -> Bool {
        user = nameField.text!
        pass = passField.text!
        
        var valid = true
        
        if user == "" {
            nameField.text = nil
            nameField.attributedPlaceholder = NSAttributedString(string:"fill the correct username or email", attributes:[NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 0.75)])
            valid = false
        }
        if pass == "" {
            passField.text = nil
            passField.attributedPlaceholder = NSAttributedString(string:"fill the correct password", attributes:[NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 0.75)])
            valid = false
        }
        return valid
    }
    
    @IBAction func Login(_ sender: UIButton) {
        if validation() {
            Auth.auth().signIn(withEmail: user, password: pass, completion: { (user, error) in
                if error == nil {
                    self.userUid =  user?.uid
                    KeychainWrapper.standard.set(self.userUid, forKey: "uid")
                    self.performSegue(withIdentifier: "toMessagesFromLogin", sender: nil)
                } else {
                    print("Gagal")
                }
                
            })
        }
    }

}
