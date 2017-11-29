//
//  LoadingIndicator.swift
//  FoodTime
//
//  Created by Christoper Jonathan on 29/11/17.
//  Copyright © 2017 binus. All rights reserved.
//

import UIKit

class LoadingIndicator {
    let view: UIView!
    let activityIndicator: UIActivityIndicatorView!
    
    init(view: UIView) {
        self.view = view
        self.activityIndicator = UIActivityIndicatorView()
        
        self.activityIndicator.activityIndicatorViewStyle = .gray
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        
        self.view.addSubview(activityIndicator)
    }
    
    func startLoading() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.activityIndicator.startAnimating()
    }
    func stopLoading() {
        UIApplication.shared.endIgnoringInteractionEvents()
        self.activityIndicator.stopAnimating()
    }
}
