//
//  OfficesMapViewRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 19.08.2022.
//

import Foundation
import UIKit

protocol OfficesMapViewRoutingLogic: AnyObject {
    func routerToDetailOffice(officeId : Int)
}

protocol OfficesMapViewDataPassing: AnyObject {
    var dataStore: OfficesMapViewDataStore? { get }
}

final class OfficesMapViewRouter: OfficesMapViewRoutingLogic, OfficesMapViewDataPassing {
    
    weak var viewController: OfficesMapViewViewController?
    var dataStore: OfficesMapViewDataStore?
    
    func routerToDetailOffice(officeId: Int) {
        let storyboard = UIStoryboard(name: "OfficeDetail", bundle: nil)
        let destVC : OfficeDetailViewController = storyboard.instantiateViewController(identifier: "OfficeDetail")
        destVC.router?.dataStore?.officeId = officeId
        self.viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
