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
    func filteredData (viewModel : ListOffices.FetchOffices.ViewModel,changeImage:Bool)
    func getCoreData(responseOfficeId:[Int])
}

final class ListOfficesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    var interactor: ListOfficesBusinessLogic?
    var router: (ListOfficesRoutingLogic & ListOfficesDataPassing)?

    var displayedOffices: [ListOffices.FetchOffices.ViewModel.Office] = []
    var coreDataOfficeId : [Int] = []
    
    @IBOutlet weak var FilterButton: UIButton!

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
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        interactor?.getCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOffices()
        tableView.register(UINib(nibName: OfficeCell.identifier, bundle: .main),forCellReuseIdentifier: OfficeCell.identifier)
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
    
    @IBAction func clickFilterButton(_ sender: Any) {
        router?.filterToOfficeData()
    }
}

extension ListOfficesViewController: ListOfficesDisplayLogic {
    
    func getCoreData(responseOfficeId: [Int]) {
        coreDataOfficeId.removeAll()
        coreDataOfficeId = responseOfficeId
        fetchData()
    }
    
    func filteredData(viewModel: ListOffices.FetchOffices.ViewModel,changeImage:Bool) {
        if changeImage {
            FilterButton.setImage(UIImage.filter, for: .normal)
        }
        else {
            FilterButton.setImage(UIImage.notFilter, for: .normal)
        }
        displayedOffices = viewModel.Offices
        tableView.reloadData()
    }
    
    func showAlert(AlertMessage: String) {
        let alert = AppConstants.alertError(Error: AlertMessage)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func displayFetchedOffices(viewModel: ListOffices.FetchOffices.ViewModel) {
        displayedOffices = viewModel.Offices
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfficeCell.identifier, for: indexPath) as? OfficeCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: displayOffice)
        cell.likeButtonDelegate = self
        cell.disLikeButtonDelegate = self
        cell.likeButton.setImage(UIImage.dislike, for: .normal)
        cell.liked = true
        for item in coreDataOfficeId { // CoreData dan gelen office id'im varsa ve oluşucak olan cellin ofis idsine eşitse like butunun image değiştiriyorum ve liked false yapıyorum ki butona basıldığında bu işlemin dislike olduğunu anlayabiliyim
            if item == displayOffice.id {
                cell.likeButton.setImage(UIImage.like, for: .normal)
                cell.liked = false
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOfficeId = displayedOffices[indexPath.row].id
        router?.routerToOfficeDetail(officeId: selectedOfficeId)
    }
}
//  MARK: Favoriye ekleme ve kaldırma işlemleri için delegate işlemeri
extension ListOfficesViewController : ClickDisLikeDelegate,ClickLikeDelegate{
    func clickDisLike(officeId: Int) {
        interactor?.deleteCoreDataModel(id:officeId)
        interactor?.getCoreData()
    }
    
    func clickLike(officeId : Int,officeName: String,officeImage: UIImage) {
        interactor?.saveCoreDataModel(id:officeId,name:officeName,image:officeImage)
        interactor?.getCoreData()
    }
    
    func fetchData() {
        tableView.reloadData()
    }
}
