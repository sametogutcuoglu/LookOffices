//
//  LoginViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 26.07.2022.
//

import Foundation
import UIKit

final class LoginViewController : UIViewController {
    
    @IBOutlet weak var triangleView: UIView!
    var count = 0
    var triangle    = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        count += 1
        
        if count == 2 {
            
            drawTriangle()
            
        }
        
    }
    
    
    private func drawTriangle() {
        
        let classTriangle = Triangle(View: self.triangleView)
        
        triangle  = classTriangle.creatUITriangle()
        
        triangleView.layer.addSublayer(triangle)
        
        loginTextCreat(ClassTriangle: classTriangle)
    }
    
    private func loginTextCreat(ClassTriangle : Triangle) {

        let login = ClassTriangle.creatMiddleTextLabel(view: triangleView, text: "Login", width: 100, height: 50)
        triangleView.addSubview(login)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available (iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }

            triangle.fillColor = UIColor.loginBackgroundColor.cgColor
    
        }
        
    }

    @IBAction func clickCreateNowButton(_ sender: Any) {
      
        //performSegue(withIdentifier: "toRegisterView", sender: nil)
        
    }
}

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
