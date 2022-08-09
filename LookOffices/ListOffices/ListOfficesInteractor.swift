//
//  ListOfficesInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesBusinessLogic: AnyObject {
    func fetchOffices()
}

protocol ListOfficesDataStore: AnyObject {
    var offices: [Office]? { get }
}

final class ListOfficesInteractor: ListOfficesBusinessLogic, ListOfficesDataStore {
    var offices: [Office]?
    var presenter: ListOfficesPresentationLogic?
    var worker = ListOfficesWorker()

    func fetchOffices() {
        // MARK: _worker. işlemleri
        worker.getFetchOffice(complation: { response in
            switch response {
            case .success(let data):
                self.offices = data
                let response = ListOffices.FetchOffices.Response(offices: data)
                self.presenter?.presentOffices(response: response)
            case .failure(let error):
                self.presenter?.Alert(AlertMessage: "Hata oluştu !  \(error)")
            }
        })
    }
}
