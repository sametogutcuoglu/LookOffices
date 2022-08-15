//
//  ListOfficesViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import UIKit
import CoreData

protocol ListOfficesDisplayLogic: AnyObject {
    func displayFetchedOffices(viewModel: ListOffices.FetchOffices.ViewModel)
    func showAlert(AlertMessage : String)
    func filteredData (viewModel : ListOffices.FetchOffices.ViewModel,changeImage:Bool)
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        getCoredata()
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
        
        let alert = UIAlertController(title: "Hata", message: AlertMessage, preferredStyle: UIAlertController.Style.alert)
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
        for item in coreDataOfficeId {
            if item == displayOffice.id {
                cell.likeButton.setImage(UIImage.like, for: .normal)
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chooseModel = displayedOffices[indexPath.row]
        router?.DetailrouterToOfficeDetail(model: chooseModel)
    }
}

extension ListOfficesViewController : ClickLikeDelegate{
    func clickDisLike(officeId: Int) {
        let appDelaget = UIApplication.shared.delegate as! AppDelegate
        let context = appDelaget.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataModel")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(officeId)")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count < 10 {
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? Int {
                        print(id)
                        if  id == officeId {
                            context.delete(result)
                            try context.save()
                        }
                    }
                }
            }
            else {
                print("obje yok")
            }
        }
        catch {
            print("Error")
        }
        getCoredata()
        tableView.reloadData()
    }
    
    func clickLike(officeId : Int,officeName: String,officeImage: UIImage) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newLikeOffice = NSEntityDescription.insertNewObject(forEntityName: "CoreDataModel", into: context)
        newLikeOffice.setValue(officeName, forKey: "officeName")
        newLikeOffice.setValue(officeId, forKey: "id")
        newLikeOffice.setValue(officeImage.jpegData(compressionQuality:0.5), forKey: "officeImage")
        do {
            try context.save()
        }
        catch {
            print("kaydetme işlemi gerçeleşmedi")
        }
    }
    
    func getCoredata() {
        coreDataOfficeId.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataModel")
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let data = try context.fetch(fetchRequest)
            for result in data as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? Int{
                    print(id)
                    coreDataOfficeId.append(id)
                }
            }
        }
        catch {
            print("olmadı")
        }
        tableView.reloadData()
    }
}

//all object delete
//        fetchRequest.returnsObjectsAsFaults = false
//        do
//        {
//            let results = try context.fetch(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                context.delete(managedObjectData)
//            }
//        } catch let error as NSError {
//
//        }
