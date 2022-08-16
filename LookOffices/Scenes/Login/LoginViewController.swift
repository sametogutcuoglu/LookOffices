//
//  LoginViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    
}

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    
    var savePassword : Bool = false
    var count = 0
    var triangle = CAShapeLayer()
    
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
        let query = [
            kSecClass : kSecClassInternetPassword,
            kSecAttrAccount : AppConstants.kSecAttrAccount,
            kSecAttrServer : AppConstants.kSecAttrServer,
            kSecAttrPath : AppConstants.kSecAttrPath,
            kSecReturnAttributes : true,
            kSecReturnData : true
        ] as CFDictionary
        
        var result : AnyObject?
        let keyChainStatus = SecItemCopyMatching(query, &result)
        print("Result : \(keyChainStatus)")
        if keyChainStatus == 0 {
            let dic = result as! NSDictionary
            let passwordData = dic[kSecValueData] as! Data
            guard let password = String(data: passwordData, encoding: .utf8) else { return }
            print(password)
            savePassword = true
        }
        else {
            print("Kayıt bulunamadı")
        }
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
    
    private func loginTextCreat(ClassTriangle: Triangle) {
        let login = ClassTriangle.creatMiddleTextLabel(view: triangleView, text: "Login", width: 100, height: 50)
        triangleView.addSubview(login)
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }

            triangle.fillColor = UIColor.loginBackgroundColor.cgColor
        }
    }
    
    @IBAction func clickCreateNowButton(_: Any) {

    }
    
    @IBAction func clickLoginButton(_:  Any) {
        if savePassword {
            print("paralo zaaten kayıtlı")
        }
        else {
            guard let password = passwordTextField.text?.data(using: .utf8) else { return }
            let keyChainItem = [
                kSecValueData: password,
                kSecAttrAccount : AppConstants.kSecAttrAccount,
                kSecAttrServer : AppConstants.kSecAttrServer,
                kSecAttrPath : AppConstants.kSecAttrPath,
                kSecClass : kSecClassInternetPassword
            ] as CFDictionary
            let status = SecItemAdd(keyChainItem, nil)
            print("kaydetdi \(status)")
        }
    }
}

extension LoginViewController: LoginDisplayLogic {
    
}
