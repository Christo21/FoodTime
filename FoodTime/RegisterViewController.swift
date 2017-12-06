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

    
    
    @IBAction func buttonRegister(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailField, password: passwordField, completion: {(user, error) in
            if error != nil {
                print("Cant create user")
            } else {
                if let user = user {
                    self.userUid = user.uid
                }
            }
           
        })
        
    }
    @IBOutlet weak var labelColor: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelColor.layer.cornerRadius = 30
        labelColor.layer.borderWidth = 5
        labelColor.layer.borderColor = UIColor.white.cgColor
        labelColor.clipsToBounds = true
        

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var textFieldUserName: UITextField!
    
    var userUid: String!
    var emailField: String!
    var passwordField: String!
    var username: String!
    
    
    //override func viewDidLoad(){
      //  super.viewDidLoad()
        
    //}
    
    override func viewDidDisappear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            performSegue(withIdentifier: "toMessage", sender: nil)
        }
    }
    
    
    @IBAction func cancel (_ sender: AnyObject){
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
