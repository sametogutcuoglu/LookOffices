//
//  ListOfficesViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import UIKit

protocol ListOfficesDisplayLogic: AnyObject {
    func displayFetchedOffices(viewModel: ListOffices.FetchOffices.ViewModel)
    func showAlert(AlertMessage : String)
    func displayOfficeDetail(index: Int)
}

final class ListOfficesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var interactor: ListOfficesBusinessLogic?
    var router: (ListOfficesRoutingLogic & ListOfficesDataPassing)?

    var displayedOffices: [ListOffices.FetchOffices.ViewModel.Office] = []

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension ListOfficesViewController: ListOfficesDisplayLogic {
    func displayOfficeDetail(index: Int) {
        router?.routerToOfficeDetail(index: index)
    }
    
     func showAlert(AlertMessage: String) {
        
        let alert = UIAlertController(title: "Hata", message: AlertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
            
        })
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func displayFetchedOffices(viewModel: ListOffices.FetchOffices.ViewModel) {
        displayedOffices = viewModel.Offices
        let list3 = displayedOffices.filter{ ($0.rooms?.isMultiple(of: 2))! }
        let list4 = list3.filter({$0.capacity!.contains("15-20")})
        print(list3.map({"\($0.capacity!)"}))
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ListOfficesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return displayedOffices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayOffice = displayedOffices[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfficeCell", for: indexPath) as? OfficeCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: displayOffice)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        displayOfficeDetail(index: indexPath.row)
    }
}

extension ListOfficesViewController: FilterDataPass  {
    func responseData(viewModel: ListOffices.FetchOffices.ViewModel) {
        displayedOffices = viewModel.Offices
        tableView.reloadData()
    }
    
    @IBAction func clickFilterButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toFilter", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilter" {
            let dsVC = segue.destination as! FilterViewController
            dsVC.filterData = displayedOffices
            dsVC.filterDataDelegate = self
        }
    }
}
