//
//  FavoriteInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 16.08.2022.
//

import Foundation
import UIKit

protocol FavoriteBusinessLogic: AnyObject {
    func deleteCoreDataModel(id: Int)
    func saveCoreDataModel(id: Int, name: String, image: UIImage)
    func getCoreData()
}

protocol FavoriteDataStore: AnyObject {
    
}

final class FavoriteInteractor: FavoriteBusinessLogic, FavoriteDataStore {
    
    var presenter: FavoritePresentationLogic?
    var worker: FavoriteWorkingLogic = FavoriteWorker()
    
    func deleteCoreDataModel(id: Int) {
        worker.deleteCoreDataModels(officeId:id)
    }
    
    func saveCoreDataModel(id: Int, name: String, image: UIImage) {
        worker.saveCoreDataModels(id: id, name: name, image: image)
    }
    
    func getCoreData() {
        worker.getCoreData { response in
            switch response {
            case .success(let coreData):
                self.presenter?.getCoreData(officesId: coreData)
            case .failure(let error):
                self.presenter?.alert(AlertMessage: error.localizedDescription)
            }
        }
    }
}
