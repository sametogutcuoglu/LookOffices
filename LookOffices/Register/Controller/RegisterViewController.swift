//
//  RegisterViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 26.07.2022.
//

import Foundation
import UIKit

final class RegisterViewController: UIViewController {
    @IBOutlet var triangleView: UIView!
    var triangle = CAShapeLayer()
    var count = 0

    override func viewDidLoad() {}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        count += 1
        if count == 2 {
            drawTriangle()
        }
    }

    private func drawTriangle() {
        let classTriangle = Triangle(View: triangleView)

        triangle = classTriangle.creatUITriangle()

        triangleView.layer.addSublayer(triangle)

        loginTextCreat(ClassTriangle: classTriangle)
    }

    public func loginTextCreat(ClassTriangle: Triangle) {
        let login = ClassTriangle.creatMiddleTextLabel(view: triangleView, text: "Register", width: 150, height: 50)
        triangleView.addSubview(login)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }

            triangle.fillColor = UIColor.loginBackgroundColor.cgColor
        }
    }

    @IBAction func clickSingUpButton(_: Any) {
        // TODO: Account created,Control E-mail and Password  min 8 character ,add scroll view
    }
}
