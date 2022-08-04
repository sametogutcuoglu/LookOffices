//
//  OfficeDetailPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

protocol OfficeDetailPresentationLogic: AnyObject {
    func presentOfficeDetail(request : OfficeDetail.FetchOfficeDetail.Response)
}

final class OfficeDetailPresenter: OfficeDetailPresentationLogic {
    weak var viewController: OfficeDetailDisplayLogic?
    
    func presentOfficeDetail(request: OfficeDetail.FetchOfficeDetail.Response) {
        
        self.viewController!.detailOffice(request: request)
       // self.viewController?.(response: request)
    }
}
