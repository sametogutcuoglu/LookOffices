//
//  MoviePlayerPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 24.08.2022.
//

import Foundation

protocol MoviePlayerPresentationLogic: AnyObject {
    
}

final class MoviePlayerPresenter: MoviePlayerPresentationLogic {
    
    weak var viewController: MoviePlayerDisplayLogic?
    
}
