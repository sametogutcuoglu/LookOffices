//
//  LoginViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 26.07.2022.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    let triangle = CAShapeLayer()
    let loginTextLayer = CATextLayer()

    @IBOutlet weak var loginButton: UIButton!
    
override func viewDidLoad() {
    super.viewDidLoad()
    creatUITriangleAndLoginText()
    
}
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available (iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
                return
            }
            triangle.fillColor = UIColor.loginBackgroundColor.cgColor
            loginTextLayer.foregroundColor = UIColor.loginTextBackgroundColor.cgColor
            loginTextLayer.backgroundColor = UIColor.loginBackgroundColor.cgColor
            
            
        }
        
    }

func creatUITriangleAndLoginText() {
    
    
    triangle.fillColor = UIColor.loginBackgroundColor.cgColor
    triangle.path = createRoundedTriangle(width: view.frame.width + 50, height:view.frame.height / 4, radius: 0)
    triangle.position = CGPoint(x: view.frame.midX, y: view.frame.midY - view.frame.height / 8)
    view.layer.addSublayer(triangle)
    

    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        // Draw the triangle path with its origin at the center.
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: -height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: 10)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: 40)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: 10)
        path.closeSubpath()

        return path
    }
    
   

    loginTextLayer.frame = CGRect(x: (view.frame.width - 100) / 2, y: view.frame.midY - view.frame.height / 9, width: 100, height: 40)
    loginTextLayer.fontSize = 35
    loginTextLayer.font = UIFont.boldSystemFont(ofSize: 50)
    loginTextLayer.alignmentMode = .center
    loginTextLayer.backgroundColor = UIColor.loginBackgroundColor.cgColor
    loginTextLayer.string = "Login"
    loginTextLayer.isWrapped = true
    loginTextLayer.truncationMode = .end
    loginTextLayer.foregroundColor = UIColor.loginTextBackgroundColor.cgColor

    view.layer.addSublayer(loginTextLayer)
}
    
}
