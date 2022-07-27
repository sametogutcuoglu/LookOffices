//
//  RegisterViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 26.07.2022.
//

import Foundation
import UIKit

final class RegisterViewController : UIViewController {
    
  
    @IBOutlet weak var TriangleView: UIView!
    
    let loginText = UILabel()
    var viewHeight : CGFloat?
    var viewWidth  : CGFloat?
    var viewMidX   : CGFloat?
    var viewMaxY   : CGFloat?
    var tirangle = CAShapeLayer()
    var count = 0
    
    override func viewDidLoad() {
        createLoginLabel()
    }
    
    func DrawTriangle() {
        
        
            let classtriangle = Triangle(width: viewWidth!, Height: viewHeight!, Radius: 40, ViewMidx: viewMidX!, ViewMaxy: viewMaxY!)
        
            tirangle = classtriangle.creatUITriangle()
        
            TriangleView.layer.addSublayer(tirangle)
        
    }
    
        

 
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
         viewHeight = TriangleView.bounds.height
         viewWidth  = TriangleView.bounds.width
         viewMidX   = TriangleView.bounds.midX
         viewMaxY   = TriangleView.bounds.maxY
        count += 1
        if count == 2 {
            DrawTriangle()
        }
    }
    

    
    private func createLoginLabel() {
        
        loginText.frame = CGRect(x: (view.frame.width - 100) / 2, y: view.frame.midY - view.frame.height / 9, width: 100, height: 40)
        loginText.font = UIFont.boldSystemFont(ofSize: 40)
        loginText.backgroundColor = .loginBackgroundColor
        loginText.textAlignment = .left
        loginText.text = "Login"
        view.addSubview(loginText)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available (iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
                return
            }
            
            tirangle.fillColor = UIColor.loginBackgroundColor.cgColor
            
            
        }
        
    }
    

    
    
    @IBAction func clickSingUpButton(_ sender: Any) {
        
        // TODO: Account created,Control E-mail and Password  min 8 character ,add scroll view
        
        
    }
}