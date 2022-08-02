//
//  ListOfficesViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import UIKit

protocol ListOfficesDisplayLogic: AnyObject {
    func displayFetchedOffices(viewModel: ListOffices.FetchOffices.ViewModel)
}

final class ListOfficesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: ListOfficesBusinessLogic?
    var router: (ListOfficesRoutingLogic & ListOfficesDataPassing)?
    
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
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        fetchOffices()
        tableView.register(UINib(nibName: "OfficeCell", bundle: .main), forCellReuseIdentifier: "OfficeCell")
    }
    
    private func fetchOffices() {
        interactor?.fetchOffices()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ListOfficesInteractor()
        let presenter = ListOfficesPresenter()
        let router = ListOfficesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    var displayedOffices: [ListOffices.FetchOffices.ViewModel.DisplayedOffice] = []
}

extension ListOfficesViewController: ListOfficesDisplayLogic {
    func displayFetchedOffices(viewModel: ListOffices.FetchOffices.ViewModel) {
        displayedOffices = viewModel.displayedOffices
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
       
    }
    
    
}

extension ListOfficesViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedOffices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayOffice = displayedOffices[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfficeCell", for: indexPath) as? OfficeCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: displayOffice)
        // Cell elemanları erime
        
        return cell
    }
    
    
}
