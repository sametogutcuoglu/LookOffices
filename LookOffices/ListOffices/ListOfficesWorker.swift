//
//  ListOfficesWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesWorkingLogic: AnyObject {}

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
}
