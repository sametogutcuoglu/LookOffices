//
//  OfficesMapViewInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 19.08.2022.
//

import Foundation

protocol OfficesMapViewBusinessLogic: AnyObject {
    func getOfficeMapInfo()
}

protocol OfficesMapViewDataStore: AnyObject {
    
}

final class OfficesMapViewInteractor: OfficesMapViewBusinessLogic, OfficesMapViewDataStore {
    
    var presenter: OfficesMapViewPresentationLogic?
    var worker: OfficesMapViewWorkingLogic = OfficesMapViewWorker()
    
    func getOfficeMapInfo() {
        worker.getOfficeMapInfo { response in
            switch response {
            case .success(let data):
                let response = OfficesMapView.Fetch.Response(OfficeMapInfo: data)
                self.presenter?.getOfficeMapInfo(response: response)
            case .failure(let error):
                self.presenter?.alert(AlertMessage: AppConstants.error + "\(error.localizedDescription)")
            }
        }
    }
    
}
