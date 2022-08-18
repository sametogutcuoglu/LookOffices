//
//  FavoriteWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 16.08.2022.
//

import Foundation
import UIKit

protocol FavoriteWorkingLogic: AnyObject {
    func deleteCoreDataModels(officeId:Int)
    func getCoreData(complation: @escaping ((Result<[Int], Error>) -> Void))
}

final class FavoriteWorker: FavoriteWorkingLogic {
    
    func deleteCoreDataModels(officeId: Int) {
        CoreDataManager().deleteCoreDataModels(officeId: officeId)
    }
    
    func getCoreData(complation: @escaping ((Result<[Int], Error>) -> Void)) {
        CoreDataManager().getCoreData { result in
            switch result {
            case .success(let response):
                complation(.success(response))
            case .failure(let error):
                complation(.failure(error))
            }
        }
    }
    
}
