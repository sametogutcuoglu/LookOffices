//
//  OfficeDetailInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

protocol OfficeDetailBusinessLogic: AnyObject {
    func fetchOffices()
}

protocol OfficeDetailDataStore: AnyObject {
    var officeId : Int? { get set}
}

final class OfficeDetailInteractor: OfficeDetailBusinessLogic, OfficeDetailDataStore {
    var officeId: Int?

    var presenter: OfficeDetailPresentationLogic?
    var worker: OfficeDetailWorkingLogic = OfficeDetailWorker()
    
    func fetchOffices() {
        guard let officeId = officeId else {
            self.presenter?.alert(Error: AppConstants.errorNilOfficeId)
            return
        }
        worker.getFetchOffice(complation: { response in
            switch response {
            case .success(let data):
                let response = OfficeDetail.FetchOfficeDetail.Response(offices: data)
                self.presenter?.presentOfficeDetail(Response: response, officeId: officeId)
            case .failure(let error): break
                self.presenter?.alert(Error: AppConstants.error + "\(error.localizedDescription)")
            }
        })
    }
}
