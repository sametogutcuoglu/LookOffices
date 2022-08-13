//
//  RegisterViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    
}

final class RegisterViewController: UIViewController {
    
    @IBOutlet var triangleView: UIView!
    
    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?

    var triangle = CAShapeLayer()
    var count = 0
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

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
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func clickSingUpButton(_: Any) {
        // TODO: Account created,Control E-mail and Password  min 8 character ,add scroll view
    }
}

extension RegisterViewController: RegisterDisplayLogic {
    
}
