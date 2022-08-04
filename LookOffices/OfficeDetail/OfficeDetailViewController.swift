//
//  OfficeDetailViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import UIKit

protocol OfficeDetailDisplayLogic: AnyObject {
 func detailOffice(request: OfficeDetail.FetchOfficeDetail.Response)
}

final class OfficeDetailViewController: UIViewController {
    
    var interactor: OfficeDetailBusinessLogic?
    var router: (OfficeDetailRoutingLogic & OfficeDetailDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func viewDidLoad() {

        fetchOffice()
    }

    func fetchOffice() {
        interactor?.fetchOffice()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeDetailInteractor()
        let presenter = OfficeDetailPresenter()
        let router = OfficeDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension OfficeDetailViewController: OfficeDetailDisplayLogic {
    func detailOffice(request: OfficeDetail.FetchOfficeDetail.Response) {
        print(request.office?.address)
    }
    
    
    
}
