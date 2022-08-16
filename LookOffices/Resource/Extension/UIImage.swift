//
//  UIImage.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 14.08.2022.
//

import Foundation
import UIKit

public extension UIImage {
    static var filter : UIImage { UIImage(imageName: "selectFilter") }
    static var notFilter : UIImage { UIImage(imageName: "filter") }
    static var like : UIImage { UIImage(imageName: "like") }
    static var dislike : UIImage { UIImage(imageName: "dislike") }
    static var notFoundImage : UIImage { UIImage(imageName: "notFoundImage") }
}

public extension UIImage {
    convenience init(imageName: String) {
        self.init(named: imageName, in: .main, compatibleWith: .current)!
    }
}
