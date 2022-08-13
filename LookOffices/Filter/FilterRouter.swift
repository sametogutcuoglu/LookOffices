//
//  FilterRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 12.08.2022.
//

import Foundation

protocol FilterRoutingLogic: AnyObject {
    
}

protocol FilterDataPassing: AnyObject {
    var dataStore: FilterDataStore? { get }
}

final class FilterRouter: FilterRoutingLogic, FilterDataPassing {
    
    weak var viewController: FilterViewController?
    var dataStore: FilterDataStore?
    
}
