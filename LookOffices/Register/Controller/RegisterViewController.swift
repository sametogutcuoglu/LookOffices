//
//  RegisterViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 26.07.2022.
//

import Foundation
import UIKit

class RegisterViewController : UIViewController {
    
  
    @IBOutlet weak var TriangleView: UIView!
    
    let triangle = CAShapeLayer()
    let logintext = UILabel()
    
    
    override func viewDidLoad() {
        creatUITriangle()
        createLoginLabel()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available (iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
                return
            }
            triangle.fillColor = UIColor.loginBackgroundColor.cgColor
            
            
        }
        
    }

func creatUITriangle() {
    
    
    triangle.fillColor = UIColor.loginBackgroundColor.cgColor
    triangle.path = createRoundedTriangle(width: view.frame.width + 50, height:view.frame.height / 4, radius: 10)
    triangle.position = CGPoint(x: view.frame.midX, y: view.frame.midY - view.frame.height / 8)

    view.layer.addSublayer(triangle)
}

    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        // Draw the triangle path with its origin at the center.
        let point1 = CGPoint(x: -width / 2, y: height / 2) // sol kenar
        let point2 = CGPoint(x: 0, y: -height / 2)  // orta nokta
        let point3 = CGPoint(x: width / 2, y: height / 2) // sağ kenar

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: 40)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()

        return path
    }
    
    func createLoginLabel() {
        
        logintext.frame = CGRect(x: (view.frame.width - 100) / 2, y: view.frame.midY - view.frame.height / 9, width: 100, height: 40)
        logintext.font = UIFont.boldSystemFont(ofSize: 40)
        logintext.backgroundColor = .loginBackgroundColor
        logintext.textAlignment = .left
        logintext.text = "Login"
        view.addSubview(logintext)
    }
    
    @IBAction func clickSingUpButton(_ sender: Any) {
        
        // TODO: Account created,Control E-mail and Password  min 8 character ,add scroll view
        
        
    }
}
