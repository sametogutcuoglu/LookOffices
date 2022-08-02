//
//  UIButton.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation
import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var radius : CGFloat  {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    
}
