//
//  ListOfficesWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation
import UIKit
import CoreData

protocol ListOfficesWorkingLogic: AnyObject {
    func saveCoreDataModels(id: Int, name: String, image: UIImage, capacity: String, room: Int, space: String)
    func deleteCoreDataModels(officeId:Int)
    func getCoreData(complation: @escaping ((Result<[Int], Error>) -> Void))
}

protocol APIOfficeProtocol {
    func getFetchOffice(complation: @escaping ((Result<[Office], Error>) -> Void))
}

final class ListOfficesWorker: ListOfficesWorkingLogic, APIOfficeProtocol {

    func getFetchOffice(complation: @escaping ((Result<[Office], Error>) -> Void)) {
        NetworkManager().getFetchOffice( complation: { result in
            switch result {
            case .success(let response):
                complation(.success(response))
            case .failure(let error):
                complation(.failure(error))
            }
        })
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
    
    func saveCoreDataModels(id: Int, name: String, image: UIImage, capacity: String, room: Int, space: String) {
        CoreDataManager().saveCoreDataModels(id: id, name: name, image: image,capacity: capacity,room: room,space: space)
    }
    
    func deleteCoreDataModels(officeId: Int) {
        CoreDataManager().deleteCoreDataModels(officeId: officeId)
    }
}
