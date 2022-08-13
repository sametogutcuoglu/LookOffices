//
//  ListOfficesPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesPresentationLogic: AnyObject {
    func presentOffices(response: ListOffices.FetchOffices.Response)
    func alert(AlertMessage: String)
    func responseFilterData (response :ListOffices.FetchOffices.ViewModel,changeImage:Bool)
}

final class ListOfficesPresenter: ListOfficesPresentationLogic {
    
    weak var viewController: ListOfficesDisplayLogic?
    
    func alert(AlertMessage: String) {
        viewController?.showAlert(AlertMessage: AlertMessage)
    }

    func presentOffices(response: ListOffices.FetchOffices.Response) {
        var displayedOffices: [ListOffices.FetchOffices.ViewModel.Office] = []
        for office in response.offices {
            let displayOffice = ListOffices.FetchOffices.ViewModel.Office(
                address: office.address ?? "",
                capacity: office.capacity ?? "",
                id: office.id ?? .zero,
                image: office.image ?? "",
                images: office.images,
                location: office.location ?? Location.init(latitude: .zero, longitude: .zero),
                name: office.name ?? "",
                rooms: office.rooms ?? .zero,
                space: office.space ?? ""
            )
            displayedOffices.append(displayOffice)
        }
        let viewModel = ListOffices.FetchOffices.ViewModel(Offices: displayedOffices)
        viewController?.displayFetchedOffices(viewModel: viewModel)
    }
    
    func responseFilterData(response :ListOffices.FetchOffices.ViewModel,changeImage:Bool) {
        var displayedOffices: [ListOffices.FetchOffices.ViewModel.Office] = []
        for office in response.Offices {
            let displayOffice = ListOffices.FetchOffices.ViewModel.Office(
                address: office.address ,
                capacity: office.capacity ,
                id: office.id ,
                image: office.image ,
                images: office.images,
                location: office.location ,
                name: office.name ,
                rooms: office.rooms ,
                space: office.space
            )
            displayedOffices.append(displayOffice)
        }
        let viewModel = ListOffices.FetchOffices.ViewModel(Offices: displayedOffices)
        self.viewController?.filteredData(viewModel: viewModel,changeImage:changeImage)
    }
}
