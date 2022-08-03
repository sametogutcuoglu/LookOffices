//
//  ListOfficesPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesPresentationLogic: AnyObject {
    func presentOffices(response: ListOffices.FetchOffices.Response)
    func Alert(AlertMessage: String)
}

final class ListOfficesPresenter: ListOfficesPresentationLogic {

    
    weak var viewController: ListOfficesDisplayLogic?
    
    func Alert(AlertMessage: String) {
        viewController?.showAlert(AlertMessage: AlertMessage)
    }

    func presentOffices(response: ListOffices.FetchOffices.Response) {
        var displayedOffices: [ListOffices.FetchOffices.ViewModel.Office] = []
        for office in response.offices {
            let displayOffice = ListOffices.FetchOffices.ViewModel.Office(
                address: office.address,
                capacity: office.capacity,
                id: office.id,
                image: office.image,
                location: office.location,
                name: office.name,
                rooms: office.rooms,
                space: office.space
            )
            displayedOffices.append(displayOffice)
        }
        let viewModel = ListOffices.FetchOffices.ViewModel(Offices: displayedOffices)
        viewController?.displayFetchedOffices(viewModel: viewModel)
    }
}
