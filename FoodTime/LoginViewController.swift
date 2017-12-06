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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUp" {
            if let destination = segue.destination as? RegisterViewController {
                if self.userUid != nil {
                    destination.userUid = userUid
                }
                if self.textFieldEmail.text != nil {
                    destination.emailField = textFieldEmail.text
                }
                if self.textFieldPassword.text != nil {
                    destination.passwordField = textFieldPassword.text
                }
            }
        }
    }
    
    @IBAction func buttonSignUpBawah(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    @IBAction func signIn (_ sender: AnyObject) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                self.userUid =  user?.uid
                    KeychainWrapper.standard.set(self.userUid, forKey: "uid")
                    
                    self.performSegue(withIdentifier: "toMessages", sender: nil)
                    
                } else {
                    print("masuk")
                }
                 
            })
            
        }
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
