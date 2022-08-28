//
//  MoviePlayerInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 24.08.2022.
//

import Foundation

protocol MoviePlayerBusinessLogic: AnyObject {
    
}

protocol MoviePlayerDataStore: AnyObject {
    
}

final class MoviePlayerInteractor: MoviePlayerBusinessLogic, MoviePlayerDataStore {
    
    var presenter: MoviePlayerPresentationLogic?
    var worker: MoviePlayerWorkingLogic = MoviePlayerWorker()
    
}
