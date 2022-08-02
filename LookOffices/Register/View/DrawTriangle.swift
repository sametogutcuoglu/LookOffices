//
//  DrawTriangle.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 27.07.2022.
//

import Foundation
import UIKit

protocol Text {
    func creatMiddleTextLabel(view:UIView, text : String ,
                              width : CGFloat , height : CGFloat) -> UIView
}

class Triangle : Text{
    

    let triangle        = CAShapeLayer()
    var view            : UIView
 
    
    init(View : UIView) {
        self.view = View
    }
    
    func creatMiddleTextLabel(view: UIView, text : String ,
                              width : CGFloat , height : CGFloat) -> UIView {
        
         let loginText = UILabel()
        
        loginText.frame = CGRect(x: view.bounds.midX - width / 2, y: view.bounds.midY, width:width, height: height)
        
        loginText.font = UIFont.boldSystemFont(ofSize: 40)
        loginText.backgroundColor = .loginBackgroundColor
        loginText.textAlignment = .center
        loginText.text = text
        return loginText
        
    }
    
    func creatUITriangle() -> CAShapeLayer {
        
        let triangleWidth   = view.bounds.width
        let triangleHeight  = view.bounds.height
        let radius          = 40.0
        let viewMidx        = view.bounds.midX
        let viewMaxY        = view.bounds.maxY
        triangle.fillColor = UIColor.loginBackgroundColor.cgColor
        
        
        triangle.path = createRoundedTriangle(width: triangleWidth, height: triangleHeight, radius: radius)
        
        triangle.frame.origin.x = viewMidx
        
        triangle.frame.origin.y = viewMaxY

        return triangle
        
    }

       private func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
            // Draw the triangle path with its origin at the center.
            let point1 = CGPoint(x: -width , y: height / 2) // sol kenar
            let point2 = CGPoint(x: 0, y: -height)  // orta nokta
            let point3 = CGPoint(x: width , y: height / 2) // sağ kenar

            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: height / 2))
            path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
            path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
            path.closeSubpath()

            return path
        }
    
}

