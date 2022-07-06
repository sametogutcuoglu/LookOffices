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
        let mainURL = Bundle.main.infoDictionary?["BACKEND_URL"] as? String
        
        print(mainURL)
    }


}

