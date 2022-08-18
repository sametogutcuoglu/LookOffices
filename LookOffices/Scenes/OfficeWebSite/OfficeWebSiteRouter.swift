//
//  OfficeWebSiteRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 17.08.2022.
//

import Foundation

protocol OfficeWebSiteRoutingLogic: AnyObject {
    
}

protocol OfficeWebSiteDataPassing: class {
    var dataStore: OfficeWebSiteDataStore? { get }
}

final class OfficeWebSiteRouter: OfficeWebSiteRoutingLogic, OfficeWebSiteDataPassing {
    
    weak var viewController: OfficeWebSiteViewController?
    var dataStore: OfficeWebSiteDataStore?
    
}
