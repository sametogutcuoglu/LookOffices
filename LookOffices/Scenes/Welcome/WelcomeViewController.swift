//
//  WelcomeViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 18.08.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    // dark view to add light effect
    lazy var shadowView: UIView = {
        let v = UIView()
        v.frame = view.bounds
        v.alpha = 0.90
        v.backgroundColor = UIColor.WelcomeBackgroundDarknees
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(shadowView)
        view.bringSubviewToFront(shadowView)
        
        label.alpha = 0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 10, height: 0)
        
        self.rightShadow()
    }
    
// MARK: - Calculate trigonometry
    func calcTrig(segment: segment, size: CGFloat, angle: CGFloat) -> [segment : CGFloat] {
        
        switch segment {
        
            case .x:
                
                let x = size
                let y = tan(angle * .pi/180) * x
                let h = x / cos(angle * .pi/180)
                return [ .x : x, .y : y, .h : h]
            
            case .y:
                
                let y = size
                let x = y / tan(angle * .pi/180)
                let h = y / sin(angle * .pi/180)
                return [ .x : x, .y : y, .h : h]
            
            case .h:
            
                let h = size
                let x = cos(angle * .pi/180) * h
                let y = sin(angle * .pi/180) * h
                return [ .x : x, .y : y, .h : h]
        }
    }
    
// MARK: - Shadow using shadowOffset
    func rightShadow() {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            
            self.label.alpha = 0.75
            self.shadowView.alpha = 0.6
            
        } completion: { success in
            
            // move it lower
            self.rightHalfBottomShadow()
            
        }
    }

    func rightHalfBottomShadow() {
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear) {
            
            self.label.alpha = 1
            let trig = self.calcTrig(segment: .h, size: 10, angle: 22.5)
            let x = trig[.x]
            let y = trig[.y]
            self.label.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.5
            
        } completion: { success in
            
            self.rightBottomShadow()
        }
    }

    func rightBottomShadow() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: 45)
            let x = trig[.x]
            let y = trig[.y]
            self.label.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.4
            
        } completion: { success in
            
            self.halfRightBottomShadow()
            
        }
    }
    
    func halfRightBottomShadow() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: 67.5)
            let x = trig[.x]
            let y = trig[.y]
            self.label.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.2
            
        } completion: { success in
            
            self.bottomShadow()
            
        }
    }
    
    func bottomShadow() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: 90)
            let x = trig[.x]
            let y = trig[.y]
            self.label.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0.1
            
        } completion: { success in
            
            self.halfLeftBottomShadow()
        }
    }

    func halfLeftBottomShadow() {
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: 112.5)
            let x = trig[.x]
            let y = trig[.y]
            self.label.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0
            
        } completion: { success in
            
            self.leftBottomShadow()
            
        }
    }

    func leftBottomShadow() {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            
            let trig = self.calcTrig(segment: .h, size: 10, angle: 135)
            let x = trig[.x]
            let y = trig[.y]
            self.label.layer.shadowOffset = CGSize(width: x!, height: y!)
            self.shadowView.alpha = 0
        }
        sleep(1)
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC : LoginViewController = storyboard.instantiateViewController(identifier: "LoginVC")
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

enum segment {
    case x
    case y
    case h
}
