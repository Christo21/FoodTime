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
    
    
    @IBOutlet weak var claimButton: UIButton!
    @IBAction func detailClaimButton(_ sender: UIButton) {
        
    }
    
    var image: UIImage!
    var name: String = ""
    var quantity: String = ""
    var note: String = ""
    var hiddenButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = image
        detailNameView.text = name
        detailQuantityView.text = quantity
        detailNoteView.text = note
        claimButton.layer.cornerRadius = 8
        claimButton.isHidden = hiddenButton
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

