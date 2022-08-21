//
//  TabbarController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 18.08.2022.
//

import UIKit

class TabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
