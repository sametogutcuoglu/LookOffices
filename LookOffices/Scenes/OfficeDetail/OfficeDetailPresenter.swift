//
//  OfficeDetailPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

protocol OfficeDetailPresentationLogic: AnyObject {
    func presentOfficeDetail(Response : ListOffices.FetchOffices.ViewModel.Office)
}

final class OfficeDetailPresenter: OfficeDetailPresentationLogic {
    
    weak var viewController: OfficeDetailDisplayLogic?
    
    func presentOfficeDetail(Response: ListOffices.FetchOffices.ViewModel.Office) {
        let displayoffice = OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail (
            address: Response.address,
            capacity: Response.capacity,
            image: Response.image,
            images: Response.images,
            name: Response.name,
            rooms: Response.rooms,
            space: Response.space)

        self.viewController?.detailOffice(viewModel: displayoffice)
    }
}
