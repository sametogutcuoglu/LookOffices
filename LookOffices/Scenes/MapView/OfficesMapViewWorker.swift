//
//  OfficesMapViewWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 19.08.2022.
//

import Foundation

protocol OfficesMapViewWorkingLogic: AnyObject {
    func getOfficeMapInfo(complation: @escaping ((Result<[Office], Error>) -> Void))
}

final class OfficesMapViewWorker: OfficesMapViewWorkingLogic {
    func getOfficeMapInfo(complation: @escaping ((Result<[Office], Error>) -> Void)) {
        NetworkManager().getFetchOffice( complation: { result in
            switch result {
            case .success(let response):
                complation(.success(response))
            case .failure(let error):
                complation(.failure(error))
            }
        })
    }
}
