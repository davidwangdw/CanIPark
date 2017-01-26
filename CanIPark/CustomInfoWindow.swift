//
//  CustomInfoWindow.swift
//  CanIPark
//
//  Created by David Wang on 1/21/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class CustomInfoWindow: UIView {
    
    //change the view of the info window
    /*override func setupView() {
        view = loadViewFromXibFile()
        view.frame = bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = NSLocalizedString("Saved_to_garage", comment: "")
        
        /// Adds a shadow to our view
        view.layer.cornerRadius = 4.0
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        view.layer.shadowOffset = CGSizeMake(0.0, 8.0)
        
        visualEffectView.layer.cornerRadius = 4.0
    }*/
    
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        
        //print("nib has awoken")
        
        //animate
        
        //parkingDataView.isHidden = true
        
        /*let viewFade = CABasicAnimation(keyPath: "opacity")
        
        viewFade.isRemovedOnCompletion = false
        
        viewFade.fromValue = 1
        viewFade.duration = 1
        viewFade.toValue = 0
        
        parkingDataView.layer.add(viewFade, forKey: "viewFade")*/
        
        //parkingDataView.isHidden = false

        
        
    }

    override func didMoveToSuperview() {
        //print("view is in superview")
        
    }
    
    

}
