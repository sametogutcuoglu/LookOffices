//
//  LoginViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 26.07.2022.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var creatButton : UIButton!
    let loginText = UILabel()
    var viewHeight : CGFloat?
    var viewWidth  : CGFloat?
    var viewMidX   : CGFloat?
    var viewMaxY   : CGFloat?
    var tiranglecreate = CAShapeLayer()
    var count = 0

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoginLabel()
    }
    
 
    func DrawTriangle() {
        
        let classtriangle = Triangle(width: viewWidth!, Height: viewHeight!, Radius: 40, ViewMidx: viewMidX!, ViewMaxy: viewMaxY!)
    
        tiranglecreate = classtriangle.creatUITriangle()
    
        triangleView.layer.addSublayer(tiranglecreate)
    }
      
    
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        viewHeight = triangleView.bounds.height
        viewWidth  = triangleView.bounds.width
        viewMidX   = triangleView.bounds.midX
        viewMaxY   = triangleView.bounds.maxY
        print(triangleView.bounds.height)
        print(triangleView.frame.height)
        print(triangleView.frame.size.height)
        count += 1
        
        if count == 2 {
       
            DrawTriangle()
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(triangleView.bounds.height)
        print(triangleView.frame.height)
        print(triangleView.frame.size.height)
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
            tiranglecreate.fillColor = UIColor.loginBackgroundColor.cgColor
            
        }
        
    }

    @IBAction func ClickCreateNowButton(_ sender: Any) {
        
        //performSegue(withIdentifier: "toRegisterView", sender: nil)
        
    }
}
