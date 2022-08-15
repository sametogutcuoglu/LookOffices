//
//  FavoriViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 15.08.2022.
//

import Foundation
import UIKit
import CoreData


class FavoriViewController : UIViewController, ClickLikeDelegate {
    func clickLike(officeId: Int, officeName: String, officeImage: UIImage) {
        
    }
    
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
        
        getdata()
        tableView.reloadData()
    }
    
    @IBOutlet var tableView: UITableView!
    var officeName : [String] = []
    var officeImage : [UIImage] = []
    var officeId : [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: OfficeCell.identifier, bundle: .main),forCellReuseIdentifier: OfficeCell.identifier)
        getdata()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
}

extension FavoriViewController : UITableViewDelegate, UITableViewDataSource {
    
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
    
}
