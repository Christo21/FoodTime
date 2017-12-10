//
//  DetailDiscoverViewController.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class DetailDiscoverViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameView: UILabel!
    @IBOutlet weak var detailQuantityView: UILabel!
    @IBOutlet weak var detailNoteView: UILabel!
    @IBOutlet weak var detailExpiredView: UILabel!
    @IBOutlet weak var detailDistanceView: UILabel!
    
    @IBOutlet weak var claimButton: UIButton!
    @IBAction func claimButtonDidTap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLogin", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLogin" {
            let destination = segue.destination as! LoginController
            destination.sharedImage = detailImageView.image
            destination.sharedName = detailNameView.text!
            destination.note = detailNoteView.text!
        }
    }
    
    var shareItem: Share!
    
    var image: UIImage!
    var name: String = ""
    var quantity: String = ""
    var expiredIn: String = "Expired in blabla days"
    var distance: String = "256 m away"
    var note: String = ""
    var hiddenButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = image
        detailImageView.layer.cornerRadius = 8
        detailImageView.clipsToBounds = true
        
        detailNameView.text = name
        detailQuantityView.text = "Quantity : \(quantity)"
        detailExpiredView.text  = "Expired in \(expiredIn)"
        detailDistanceView.text = distance
        detailNoteView.text = note
        claimButton.layer.cornerRadius = 8
        claimButton.isHidden = hiddenButton
        // Do any additional setup after loading the view.
        self.title = "Detail Item"
        
    }
    @IBAction func unwindToDetailDiscover(segue:UIStoryboardSegue) {    }
    
}


