//
//  ListOfficesRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation
import UIKit

protocol ListOfficesRoutingLogic: AnyObject {
    func routerToOfficeDetail(index: Int)
    func filterToOfficeData()
}

protocol ListOfficesDataPassing: AnyObject {
    var dataStore: ListOfficesDataStore? { get }
}

final class ListOfficesRouter: ListOfficesRoutingLogic, ListOfficesDataPassing, FilterDataPass {
  
    weak var viewController: ListOfficesViewController?
    var dataStore: ListOfficesDataStore?
    
    func routerToOfficeDetail(index: Int) {
        let storyboard = UIStoryboard(name: "OfficeDetail", bundle: nil)
        let destVC : OfficeDetailViewController = storyboard.instantiateViewController(identifier: "OfficeDetail")
        destVC.router?.dataStore?.office = dataStore?.offices[index]
        self.viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func filterToOfficeData() {
        let filtreStoryboard = UIStoryboard(name: "Filter", bundle: nil)
        let filterVC : FilterViewController = filtreStoryboard.instantiateViewController(identifier: "filterViewController")
        filterVC.filterDataDelegate = self
        filterVC.router?.dataStore?.officedata = dataStore?.offices
        self.viewController?.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    func responseFilterData(viewModel: ListOffices.FetchOffices.ViewModel,changeImage:Bool) {
        dataStore?.responseFilterData(data: viewModel,changeImage:changeImage)
    }
}
