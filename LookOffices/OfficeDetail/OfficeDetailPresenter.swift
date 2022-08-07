//
//  OfficeDetailPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

protocol OfficeDetailPresentationLogic: AnyObject {
    func presentOfficeDetail(Response : OfficeDetail.FetchOfficeDetail.Response)
}

final class OfficeDetailPresenter: OfficeDetailPresentationLogic {
    weak var viewController: OfficeDetailDisplayLogic?
    
    func presentOfficeDetail(Response: OfficeDetail.FetchOfficeDetail.Response) {
        let displayoffice = OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail (
            address: Response.office?.address,
            capacity: Response.office?.capacity,
            image: Response.office?.image,
            images: Response.office?.images,
            name: Response.office?.name,
            rooms: Response.office?.rooms,
            space: Response.office?.space)

        self.viewController?.detailOffice(viewModel: displayoffice)
    }
}
