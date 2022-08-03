//
//  Extensions.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 2.08.2022.
//

import Foundation
import UIKit

@IBDesignable extension UIButton {
    @IBInspectable var radius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
}
