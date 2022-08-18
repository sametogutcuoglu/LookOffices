//
//  LoginRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation
import UIKit

protocol LoginRoutingLogic: AnyObject {
    func getOfficeList()
    func getRegister()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func getOfficeList() {
        let storyboard = UIStoryboard(name: "ListOffices", bundle: nil)
        let loginVC : TabbarController = storyboard.instantiateViewController(identifier: "TabbarController")
        self.viewController?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func getRegister() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let loginVC : RegisterViewController = storyboard.instantiateViewController(identifier: "RegisterVC")
        self.viewController?.navigationController?.pushViewController(loginVC, animated: true)
    }
}
