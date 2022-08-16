//
//  FavoriteRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 16.08.2022.
//

import Foundation
import UIKit

protocol FavoriteRoutingLogic: AnyObject {
    func routerToOfficeDetail(officeId: Int)
}

protocol FavoriteDataPassing: AnyObject {
    var dataStore: FavoriteDataStore? { get }
}

final class FavoriteRouter: FavoriteRoutingLogic, FavoriteDataPassing {
    
    func routerToOfficeDetail(officeId: Int) {
        let storyboard = UIStoryboard(name: "OfficeDetail", bundle: nil)
        let officeDetailVC : OfficeDetailViewController = storyboard.instantiateViewController(identifier: "OfficeDetail")
        //destVC.router?.dataStore?.officeDetail = model
        officeDetailVC.router?.dataStore?.officeId = officeId
        officeDetailVC.modalPresentationStyle = .fullScreen

        self.viewController?.present(officeDetailVC, animated: true, completion: nil)

       
    }
    func navigateToRocketDetail(source: FavoriteViewController, destination: OfficeDetailViewController) {
      source.show(destination, sender: nil)
    }
    
    
    weak var viewController: FavoriteViewController?
    var dataStore: FavoriteDataStore?
    
}
