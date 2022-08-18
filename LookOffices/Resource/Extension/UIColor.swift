//
//  UIcolor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 26.07.2022.
//

import Foundation
import UIKit

public extension UIColor {
    static var loginBackgroundColor: UIColor { UIColor(colorName: "LoginBackground") }
    static var loginTextBackgroundColor: UIColor { UIColor(colorName: "loginTextColor") }
    static var loginTopViewBackgroundColor: UIColor { UIColor(colorName: "LoginTopBackground") }
    static var filtreViewBorderColor: UIColor { UIColor(colorName: "FiltreViewBorderColor") }
    static var WelcomeBackgroundDarknees: UIColor { UIColor(colorName: "WelcomeBackgroundDarknees") }
    
}

public extension UIColor {
    convenience init(colorName: String) {
        self.init(named: colorName, in: .main, compatibleWith: .current)!
    }
}
