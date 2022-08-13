//
//  UIView.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 12.08.2022.
//

import Foundation
import UIKit


extension UIView {
  func addBorder() {
      
      self.layer.borderWidth = 2
      self.layer.borderColor = UIColor.lightGray.cgColor
      self.layer.cornerRadius = 5
  }
}
