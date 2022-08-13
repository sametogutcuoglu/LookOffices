//
//  FilterWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 12.08.2022.
//

import Foundation

protocol FilterWorkingLogic: AnyObject {
    func getWillFilterData(complation: @escaping ((Result<[Office], Error>) -> Void))
}

final class FilterWorker: FilterWorkingLogic {
    func getWillFilterData(complation: @escaping ((Result<[Office], Error>) -> Void)) {
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
