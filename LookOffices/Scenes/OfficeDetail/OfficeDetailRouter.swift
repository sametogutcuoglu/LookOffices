//
//  OfficeDetailRouter.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import Foundation
import UIKit

protocol OfficeDetailRoutingLogic: AnyObject {
    func openOfficeWebSite()
    func openVideoPlayerController()
}

protocol OfficeDetailDataPassing: AnyObject {
    var dataStore: OfficeDetailDataStore? { get }
}

final class OfficeDetailRouter: OfficeDetailRoutingLogic, OfficeDetailDataPassing {
    
    weak var viewController: OfficeDetailViewController?
    var dataStore: OfficeDetailDataStore?
    
    func openOfficeWebSite() {
        let stroyboard = UIStoryboard(name: "OfficeWebSite", bundle: nil)
        let OfficeWebSiteStoryboard : OfficeWebSiteViewController = stroyboard.instantiateViewController(identifier: "OfficeWebsite")
        self.viewController?.navigationController?.pushViewController(OfficeWebSiteStoryboard, animated: true)
    }
    
    func openVideoPlayerController() {
        let stroyboardMoviePlayer = UIStoryboard(name: "MoviePlayer", bundle: nil)
        guard let moviePlayVC : MoviePlayerViewController = stroyboardMoviePlayer.instantiateViewController(withIdentifier: "MoviePlayer") as? MoviePlayerViewController else { return }
        moviePlayVC.modalPresentationStyle = .fullScreen
        moviePlayVC.isModalInPresentation = false
        self.viewController?.present(moviePlayVC, animated: true)
    }
}
