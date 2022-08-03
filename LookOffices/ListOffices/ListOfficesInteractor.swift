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

        guard let url = URL(string: AppConstants.firebaseURL) else {
            return // popup alert Appconstant.Urlnotfound
        }
        worker.getFetchOffice(url: url) { response in
            if let officeList = response {
                let response = ListOffices.FetchOffices.Response(offices: officeList)
                self.presenter?.presentOffices(response: response)
            } else {
                print("Liste Boş") // popup alert
            }
        }
    }
}
