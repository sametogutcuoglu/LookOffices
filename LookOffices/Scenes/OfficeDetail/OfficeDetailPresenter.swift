//
//  OfficeDetailPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation

protocol OfficeDetailPresentationLogic: AnyObject {
    func presentOfficeDetail(Response : OfficeDetail.FetchOfficeDetail.Response,officeId: Int)
    func alert(Error : String)
}

final class OfficeDetailPresenter: OfficeDetailPresentationLogic {
    
    weak var viewController: OfficeDetailDisplayLogic?
    func presentOfficeDetail(Response: OfficeDetail.FetchOfficeDetail.Response,officeId: Int) {
        var displayedOffices: [OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail] = []
        for item in Response.offices {
            let officeDetailmodel = OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail(
                id: item.id ?? .zero,
                address: item.address ?? "",
                capacity: item.capacity ?? "",
                officePosterImage: item.image ?? "",
                officeDetailimages: item.images,
                name: item.name ?? "",
                rooms: item.rooms ?? .zero,
                space: item.space ?? "")
            
            displayedOffices.append(officeDetailmodel)
        }
        
        let officeDetailModel = displayedOffices.filter(({$0.id.words.contains(Int.Words.Element(officeId)) }))
        if officeDetailModel.count <= 1 {
            self.viewController?.detailOffice(viewModel: officeDetailModel[0])
        }
        else {
            self.viewController?.showAlert(error: AppConstants.errorNotFoundOfficeId)
        }
    }
    
    func alert(Error: String) {
        viewController?.showAlert(error: Error)
    }
}
