///Users/petrapradnyapramesthi/Documents/FoodTime/FoodTime/Base.lproj/Main.storyboard
//  RegistViewController.swift
//  FoodTime
//
//  Created by Petra Pradnya Pramesthi on 10/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class RegistViewController: UIViewController, UITextFieldDelegate{

    @IBAction func loginButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var registButton: UIButton!
    @IBAction func cancelButton(_ sender: UIButton) {
       self.performSegue(withIdentifier: "unwindToDetailDiscover", sender: sender)
    }
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var pass2Field: UITextField!
    
    var userUid: String!
    var userCoreData: CoreDataClass = CoreDataClass(entity: "UserModel")
    
    @IBAction func Register(_ sender: UIButton){
        if let email = emailField.text, let password = passField.text, let username = usernameField.text{
            print("\(email) \(password)")
            
            Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                if error != nil {
                    print("Cant create user")
                } else {
                    if let user = user {
                        self.userUid = user.uid
                        let user = User(name: username, password: password, address: "", id: user.uid)
                        self.userCoreData.saveData(object: user)
                        self.performSegue(withIdentifier: "toMessages", sender: nil)
                    }
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registButton.layer.cornerRadius = 8
        usernameField.frame.size.height = 40
        emailField.frame.size.height = 40
        passField.frame.size.height = 40
        pass2Field.frame.size.height = 40
        
        passField.delegate = self
        pass2Field.delegate = self
        
        hideKeyboardWhenTappedAround()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.pass2Field {
            animation(y: -80)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.pass2Field {
            animation(y: 80)
        }
    }
    func animation(y: CGFloat) {
        UIView .beginAnimations(nil, context: nil)
        UIView .setAnimationDelegate(self)
        UIView .setAnimationDuration(0.5)
        UIView .setAnimationBeginsFromCurrentState(true)
        self.view.frame = CGRect(x: self.view.frame.origin.x, y: (self.view.frame.origin.y + y), width: self.view.frame.size.width, height: self.view.frame.size.height)
        UIView .commitAnimations()
    }
}
