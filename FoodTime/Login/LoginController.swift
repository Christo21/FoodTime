//
//  LoginController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 29/11/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
        nameField.frame.size.height = 40
        passField.frame.size.height = 40
        hideKeyboardWhenTappedAround()
    }

}
