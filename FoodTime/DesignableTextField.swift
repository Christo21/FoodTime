//
//  DesignableTextField.swift
//  FoodTime
//
//  Created by Liana Ester Wulandari on 05/12/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage : UIImage! {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView( frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            let width = leftPadding + 20
            let view = UIView ( frame:  CGRect (x: 0, y: 0, width: width, height: 20))
            
            view.addSubview(imageView)
            leftView = view
        } else {
            //image is nill
            leftViewMode = .never
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
