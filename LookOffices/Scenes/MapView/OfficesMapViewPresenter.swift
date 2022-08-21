//
//  OfficesMapViewPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 19.08.2022.
//

import Foundation

protocol OfficesMapViewPresentationLogic: AnyObject {
    func getOfficeMapInfo(response : OfficesMapView.Fetch.Response)
    func alert(AlertMessage: String)
}

final class OfficesMapViewPresenter: OfficesMapViewPresentationLogic {
    
    weak var viewController: OfficesMapViewDisplayLogic?
    
    func getOfficeMapInfo(response: OfficesMapView.Fetch.Response) {
        
        var displayOfficesMapInfo: [OfficesMapView.Fetch.ViewModel.OfficeMapInfo] = []
        for office in response.OfficeMapInfo {
            let displayOfficeMapInfo = OfficesMapView.Fetch.ViewModel.OfficeMapInfo(
                id: office.id ?? .zero,
                latitude: office.location?.latitude ?? .zero,
                longidute: office.location?.longitude ?? .zero,
                name: office.name ?? "")
            displayOfficesMapInfo.append(displayOfficeMapInfo)
    }
        let viewModel = OfficesMapView.Fetch.ViewModel.init(officesMapInfo: displayOfficesMapInfo)
        viewController?.getOfficeMapInfo(response: viewModel)
  }
    func alert(AlertMessage: String) {
        viewController?.showAlert(AlertMessage: AlertMessage)
    }
}
