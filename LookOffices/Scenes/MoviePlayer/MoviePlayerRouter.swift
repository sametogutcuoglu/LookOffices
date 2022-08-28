//
//  MoviePlayerRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 24.08.2022.
//

import Foundation

protocol MoviePlayerRoutingLogic: AnyObject {
    
}

protocol MoviePlayerDataPassing: class {
    var dataStore: MoviePlayerDataStore? { get }
}

final class MoviePlayerRouter: MoviePlayerRoutingLogic, MoviePlayerDataPassing {
    
    weak var viewController: MoviePlayerViewController?
    var dataStore: MoviePlayerDataStore?
    
}
