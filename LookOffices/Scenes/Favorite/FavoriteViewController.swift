//
//  FavoriteViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 16.08.2022.
//

import UIKit
import CoreData

protocol FavoriteDisplayLogic: AnyObject {
    func getCoreData(responseOfficeId:[Int])
}

final class FavoriteViewController: UIViewController {
    
    var interactor: FavoriteBusinessLogic?
    var router: (FavoriteRoutingLogic & FavoriteDataPassing)?
    
    @IBOutlet var tableView: UITableView!
    var officeName : [String] = []
    var officeImage : [UIImage] = []
    var officeId : [Int] = []
    
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
        tableView.register(UINib(nibName: OfficeCell.identifier, bundle: .main),forCellReuseIdentifier: OfficeCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        interactor?.getCoreData()
        officeImage.removeAll()
        officeId.removeAll()
        officeName.removeAll()
        getdata()
        tableView.reloadData()
    }
    
    private func getdata() {
        officeImage.removeAll()
        officeId.removeAll()
        officeName.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataModel")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let data = try context.fetch(fetchRequest)

            for result in data as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? Int{
                    officeId.append(id)
                }
                if let name = result.value(forKey: "officeName") as? String {
                    officeName.append(name)
                }
                if let image = result.value(forKey: "officeImage") as? Data {
                    guard let data = UIImage(data: image) else { return }
                    officeImage.append(data)
                }
            }
        }
        catch {
      
        }
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FavoriteInteractor()
        let presenter = FavoritePresenter()
        let router = FavoriteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FavoriteViewController: FavoriteDisplayLogic {
    
    func getCoreData(responseOfficeId: [Int]) {
        officeId.removeAll()
        officeId = responseOfficeId
        fetchData()
    }
}

extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return officeId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfficeCell.identifier, for: indexPath) as? OfficeCell else {
            return UITableViewCell()
        }
        cell.configure(image: officeImage[indexPath.row], Name: officeName[indexPath.row], officeId: officeId[indexPath.row])
        cell.likeButton.setImage(UIImage.like, for: .normal)
        cell.liked = false
        cell.disLikeButtonDelegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routerToOfficeDetail(officeId: officeId[indexPath.row])
    }
}

extension FavoriteViewController: ClickDisLikeDelegate {
    func clickDisLike(officeId: Int) {
        interactor?.deleteCoreDataModel(id:officeId)
        interactor?.getCoreData()
    }
    func fetchData() {
        tableView.reloadData()
    }
}
