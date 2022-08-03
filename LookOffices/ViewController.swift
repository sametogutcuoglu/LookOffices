//
//  ViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 4.07.2022.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITriangleAndLoginTextCreated()
    }

    func UITriangleAndLoginTextCreated() {
        let triangle = CAShapeLayer()
        triangle.fillColor = UIColor.white.cgColor
        triangle.path = createRoundedTriangle(width: view.frame.width + 50, height: view.frame.height / 4, radius: 0)
        triangle.position = CGPoint(x: view.frame.midX, y: view.frame.midY - view.frame.height / 8)
        view.layer.addSublayer(triangle)

        func createRoundedTriangle(width: CGFloat, height: CGFloat, radius _: CGFloat) -> CGPath {
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

        let loginTextLayer = CATextLayer()

        loginTextLayer.frame = CGRect(x: (view.frame.width - 100) / 2, y: view.frame.midY - view.frame.height / 9, width: 100, height: 40)
        loginTextLayer.fontSize = 35
        loginTextLayer.font = UIFont.boldSystemFont(ofSize: 50)
        loginTextLayer.alignmentMode = .center
        loginTextLayer.backgroundColor = UIColor.white.cgColor
        loginTextLayer.string = "Login"
        loginTextLayer.isWrapped = true
        loginTextLayer.truncationMode = .end
        loginTextLayer.foregroundColor = UIColor.black.cgColor

        view.layer.addSublayer(loginTextLayer)
    }
}
