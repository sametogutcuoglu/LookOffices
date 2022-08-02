//
//  ListOfficesPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesPresentationLogic: AnyObject {
    func presentOffices(response: ListOffices.FetchOffices.Response)
}

final class ListOfficesPresenter: ListOfficesPresentationLogic {
    
    weak var viewController: ListOfficesDisplayLogic?
    
    func presentOffices(response: ListOffices.FetchOffices.Response) {
        var displayedOffices : [ListOffices.FetchOffices.ViewModel.DisplayedOffice] = []
        for office in response.Offices {
            let displayOffice = ListOffices.FetchOffices.ViewModel.DisplayedOffice(
                address: office.address,
                capacity: office.capacity,
                id: office.id,
                image: office.image,
                location: office.location,
                name: office.name,
                rooms: office.rooms,
                space: office.space)
            displayedOffices.append(displayOffice)
        }
        let viewModel = ListOffices.FetchOffices.ViewModel(displayedOffices: displayedOffices)
        viewController?.displayFetchedOffices(viewModel: viewModel)
    }
    
    

    
}
