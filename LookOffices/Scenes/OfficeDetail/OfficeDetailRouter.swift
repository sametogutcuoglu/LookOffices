//
//  OfficeDetailRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation
import UIKit

protocol OfficeDetailRoutingLogic: AnyObject {
    func openOfficeWebSite()
}

protocol OfficeDetailDataPassing: AnyObject {
    var dataStore: OfficeDetailDataStore? { get }
}

final class OfficeDetailRouter: OfficeDetailRoutingLogic, OfficeDetailDataPassing {
    
    weak var viewController: OfficeDetailViewController?
    var dataStore: OfficeDetailDataStore?
    
    func openOfficeWebSite() {
        let stroyboard = UIStoryboard(name: "OfficeWebSite", bundle: nil)
        let OfficeWebSiteStoryboard : OfficeWebSiteViewController = stroyboard.instantiateViewController(identifier: "OfficeWebsite")
        self.viewController?.navigationController?.pushViewController(OfficeWebSiteStoryboard, animated: true)
    }
}
