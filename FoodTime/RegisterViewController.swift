//
//  RegisterViewController.swift
//  FoodTime
//
//  Created by Liana Ester Wulandari on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBAction func buttonRegister(_ sender: Any) {
        
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
