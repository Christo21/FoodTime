//
//  HomeTableViewCell.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 04/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteOfImage: UILabel!
    @IBOutlet weak var expiredDateOfImage: UILabel!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var indicator: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

