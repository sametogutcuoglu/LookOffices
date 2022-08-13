//
//  FilterInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 12.08.2022.
//

import Foundation

protocol FilterBusinessLogic: AnyObject {
    func getDistinctFilterData()
    func getfetchWillFilterData()
}

protocol FilterDataStore: AnyObject {
    var officedata : [Office]? { get set }
}

final class FilterInteractor: FilterBusinessLogic, FilterDataStore {
    
    var officedata: [Office]?

    var presenter: FilterPresentationLogic?
    var worker: FilterWorkingLogic = FilterWorker()
    
    func getDistinctFilterData() {
        worker.getWillFilterData(complation: { response in
            switch response {
            case .success(let data):
                
                let response = Filter.Fetch.Response(offices: data)
                self.presenter?.getDistinctFilterData(response: response)
            case .failure(_):
                    return
            }
        })
    }
    
    func getfetchWillFilterData() {
        guard let officedata = officedata else { return }
        self.presenter?.getFetchWillFilterData(data: officedata )
    }
}
