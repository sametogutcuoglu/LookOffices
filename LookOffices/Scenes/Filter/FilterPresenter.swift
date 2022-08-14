//
//  FilterPresenter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 12.08.2022.
//

import Foundation

protocol FilterPresentationLogic: AnyObject {
    func getDistinctFilterData(response: Filter.Fetch.Response)
    func getFetchWillFilterData(data: [Office],capacity:String,room:String,space:String)
}

final class FilterPresenter: FilterPresentationLogic {
    weak var viewController: FilterDisplayLogic?
    
    func getDistinctFilterData(response: Filter.Fetch.Response) {
        var displayedOffices: [Filter.Fetch.ViewModel.filterData] = []
        for office in response.offices {
            let displayOffice = Filter.Fetch.ViewModel.filterData(
                capacity: office.capacity ?? "",
                rooms: office.rooms ?? .zero,
                space: office.space ?? ""
            )
            displayedOffices.append(displayOffice)
        }
        var capacity : [String] = []
        var room : [Int] = []
        var space : [String] = []
        
        for item in displayedOffices {
            capacity.append(item.capacity)
            room.append(item.rooms)
            space.append(item.space)
        }
        let distinctCapacity = Array(Set(capacity))
        let distinctroom = Array(Set(room))
        let distinctspace = Array(Set(space))
        
        viewController?.distinctFilterData(capacity: distinctCapacity, room: distinctroom, space: distinctspace)
    }
    
    func getFetchWillFilterData(data: [Office],capacity:String,room:String,space:String) {
        var willFilterDatas: [ListOffices.FetchOffices.ViewModel.Office] = []
        for item in data {
            let willFilterData = ListOffices.FetchOffices.ViewModel.Office(address: item.address ?? "",
                                                                        capacity: item.capacity ?? "",
                                                                        id: item.id ?? .zero,
                                                                        image: item.image ?? "",
                                                                        images: item.images,
                                                                        location: item.location ?? Location.init(latitude: .zero, longitude: .zero),
                                                                        name: item.name ?? "",
                                                                        rooms: item.rooms ?? .zero,
                                                                        space: item.space ?? "")
            willFilterDatas.append(willFilterData)
        }
        var chooseImage : Bool = false
            if  capacity == AppConstants.filterDefaultText {
                
            }
            else {
                chooseImage = true
                willFilterDatas = willFilterDatas.filter({$0.capacity.contains(capacity)})
            }
            if room == AppConstants.filterDefaultText {
                
            }
            else {
                chooseImage = true
                willFilterDatas = willFilterDatas.filter({$0.rooms.isMultiple(of: Int(room)!) })
            }
            if space == AppConstants.filterDefaultText {
                
            }
            else {
                chooseImage = true
                willFilterDatas = willFilterDatas.filter({$0.space.contains(space) })
            }
        
        viewController?.FilterOfficesData(viewModel: ListOffices.FetchOffices.ViewModel(Offices: willFilterDatas),
                                          chooseImage: chooseImage)
    }
    
}
