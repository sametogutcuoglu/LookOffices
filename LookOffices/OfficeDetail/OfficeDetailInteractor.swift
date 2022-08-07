//
//  OfficeDetailInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

protocol OfficeDetailBusinessLogic: AnyObject {
    func fetchOffice()
}

protocol OfficeDetailDataStore: AnyObject {
    var office : Office? {get set }
}

final class OfficeDetailInteractor: OfficeDetailBusinessLogic, OfficeDetailDataStore {
    var office: Office?
    var presenter: OfficeDetailPresentationLogic?
    var worker: OfficeDetailWorkingLogic = OfficeDetailWorker()
    
    func fetchOffice() {
        let response = OfficeDetail.FetchOfficeDetail.Response(office: office)
        self.presenter?.presentOfficeDetail(Response: response)
    }
}
