//
//  RegistViewController.swift
//  FoodTime
//
//  Created by Petra Pradnya Pramesthi on 10/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registButton.layer.cornerRadius = 8
        usernameField.frame.size.height = 40
        emailField.frame.size.height = 40
        passField.frame.size.height = 40
        pass2Field.frame.size.height = 40
        hideKeyboardWhenTappedAround()
    }

}
