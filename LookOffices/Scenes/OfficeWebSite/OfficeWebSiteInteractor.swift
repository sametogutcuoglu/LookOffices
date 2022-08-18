//
//  OfficeWebSiteInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 17.08.2022.
//

import Foundation

protocol OfficeWebSiteBusinessLogic: AnyObject {
    
}

protocol OfficeWebSiteDataStore: AnyObject {
    
}

final class OfficeWebSiteInteractor: OfficeWebSiteBusinessLogic, OfficeWebSiteDataStore {
    
    var presenter: OfficeWebSitePresentationLogic?
    var worker: OfficeWebSiteWorkingLogic = OfficeWebSiteWorker()
    
}
