//
//  ListOfficesRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesRoutingLogic: AnyObject {
    
}

protocol ListOfficesDataPassing: class {
    var dataStore: ListOfficesDataStore? { get }
}

final class ListOfficesRouter: ListOfficesRoutingLogic, ListOfficesDataPassing {
    
    weak var viewController: ListOfficesViewController?
    var dataStore: ListOfficesDataStore?
    
}
