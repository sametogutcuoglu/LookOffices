//
//  OfficeDetailWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

protocol OfficeDetailWorkingLogic: AnyObject {
    func getFetchOffice(complation: @escaping ((Result<[Office], Error>) -> Void))
}

final class OfficeDetailWorker: OfficeDetailWorkingLogic {
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
}
