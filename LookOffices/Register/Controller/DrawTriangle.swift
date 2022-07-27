//
//  DrawTriangle.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 27.07.2022.
//

import Foundation
import UIKit

class Triangle {
    
    let triangle        = CAShapeLayer()
    var triangleWidth   : CGFloat
    var triangleHeight  : CGFloat
    var radius          : CGFloat
    var viewMidx        : CGFloat
    var viewMaxY        : CGFloat
    
    
    init(triangleWidth : CGFloat , triangleHeight : CGFloat ,
         Radius : CGFloat, ViewMidx : CGFloat , ViewMaxy : CGFloat) {
        self.triangleWidth    = triangleWidth
        self.triangleHeight   = triangleHeight
        self.radius   = Radius
        self.viewMidx = ViewMidx
        self.viewMaxY = ViewMaxy
    }
   
   
    
    func creatUITriangle() -> CAShapeLayer {
        
        
        triangle.fillColor = UIColor.loginBackgroundColor.cgColor
        
        triangle.path = createRoundedTriangle(width: triangleWidth, height: triangleHeight, radius: radius)
        
        triangle.frame.origin.x = viewMidx
        
        triangle.frame.origin.y = viewMaxY

        return triangle
        
    }

        func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
            // Draw the triangle path with its origin at the center.
            let point1 = CGPoint(x: -width, y: height / 2) // sol kenar
            let point2 = CGPoint(x: 0, y: -height)  // orta nokta
            let point3 = CGPoint(x: width, y: height / 2) // sağ kenar

            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: height / 2))
            path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
            path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
            path.closeSubpath()

            return path
        }
    
}
