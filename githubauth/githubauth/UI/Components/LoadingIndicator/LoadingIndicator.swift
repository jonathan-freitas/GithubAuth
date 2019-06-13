//
//  LoadingIndicator.swift
//  githubauth
//
//  Created by Jonathan Freitas on 12/06/19.
//  Copyright © 2019 jonathan. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialActivityIndicator

class LoadingIndicator {
    
    var parentView: UIView?
    var activityIndicator: MDCActivityIndicator?
    
    /// Function responsible for adding and starting the activity indicator in the given view.
    func startActivityIndicator(view: UIView) {
        
        if activityIndicator == nil {
            
            // View
            parentView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            parentView!.backgroundColor = UIColor(white: 0, alpha: 0.5)
            view.addSubview(parentView!)
            view.bringSubviewToFront(parentView!)
            
            // Activity Indicator
            activityIndicator = MDCActivityIndicator()
            activityIndicator!.sizeToFit()
            parentView!.addSubview(activityIndicator!)
            activityIndicator!.cycleColors = [UIColor.lightGray]
            activityIndicator!.radius = 24
            activityIndicator!.center = parentView!.center
            activityIndicator!.startAnimating()
        }
    }
    
    /// Function responsible for removing the activity indicator from the view.
    func stopActivityIndicator() {
        if activityIndicator != nil {
            activityIndicator!.stopAnimating()
            activityIndicator!.removeFromSuperview()
            parentView!.removeFromSuperview()
            activityIndicator = nil
            parentView = nil
        }
    }
}
