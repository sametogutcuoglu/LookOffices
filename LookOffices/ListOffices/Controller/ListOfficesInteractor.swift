//
//  ListOfficesInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesBusinessLogic: AnyObject {
    func fetchOffices(request : ListOffices.FetchOffices.Request)
}

protocol ListOfficesDataStore: AnyObject {
    var offices: [Office]? { get }
}

final class ListOfficesInteractor: ListOfficesBusinessLogic, ListOfficesDataStore {
    var offices: [Office]?
    var presenter: ListOfficesPresentationLogic?
    var worker =   ListOfficesWorker()
    
    func fetchOffices(request: ListOffices.FetchOffices.Request) {
        // MARK: _worker. işlemleri
        let url = URL(string: "https://officer-ad6ef-default-rtdb.firebaseio.com/offices.json")
        worker.getFecthOffice(url: url!) { OfficeList in
            if OfficeList != nil {
                let response = ListOffices.FetchOffices.Response(Offices: OfficeList!)
                self.presenter?.presentOffices(response: response)
            }
            else {
                print("Liste Boş")
            }
           
        }
    }
    
    

    
}
