//
//  FavoritePresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 16.08.2022.
//

import Foundation

protocol FavoritePresentationLogic: AnyObject {
    func alert(AlertMessage: String)
    func getCoreData(officesId : [Int])
}

final class FavoritePresenter: FavoritePresentationLogic {
    
    weak var viewController: FavoriteDisplayLogic?
    
    func alert(AlertMessage: String) {
        
    }
    
    func getCoreData(officesId: [Int]) {
        viewController?.getCoreData(responseOfficeId: officesId)
    }
    
}
