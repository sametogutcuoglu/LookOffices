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
    var officeDetail : ListOffices.FetchOffices.ViewModel.Office? {get set }
}

final class OfficeDetailInteractor: OfficeDetailBusinessLogic, OfficeDetailDataStore {
    var officeDetail: ListOffices.FetchOffices.ViewModel.Office?

    var office: Office?
    var presenter: OfficeDetailPresentationLogic?
    var worker: OfficeDetailWorkingLogic = OfficeDetailWorker()
    
    func fetchOffice() {

        guard let model = officeDetail else {return}
        self.presenter?.presentOfficeDetail(Response: model)
    }
}
