//
//  ListOfficesInteractor.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation
import UIKit

protocol ListOfficesBusinessLogic: AnyObject {
    func fetchOffices()
    func saveCoreDataModel(id:Int,name:String,image:UIImage)
    func deleteCoreDataModel(id:Int)
    func getCoreData()
}

protocol ListOfficesDataStore: AnyObject {
    var offices: [Office] { get set }
    func responseFilterData(data : ListOffices.FetchOffices.ViewModel,changeImage:Bool)
}

final class ListOfficesInteractor: ListOfficesBusinessLogic, ListOfficesDataStore {
    
    func responseFilterData(data: ListOffices.FetchOffices.ViewModel,changeImage:Bool) {
        self.presenter?.responseFilterData(response: data,changeImage:changeImage)
    }
    
    var offices: [Office] = []
    var presenter: ListOfficesPresentationLogic?
    var worker = ListOfficesWorker()

    func fetchOffices() {
        // MARK: _worker. işlemleri
        worker.getFetchOffice(complation: { response in
            switch response {
            case .success(let data):
                self.offices = data
                let response = ListOffices.FetchOffices.Response(offices: data)
                self.presenter?.presentOffices(response: response)
            case .failure(let error):
                self.presenter?.alert(AlertMessage: AppConstants.error + "\(error.localizedDescription)")
            }
        })
    }
    
    func saveCoreDataModel(id: Int, name: String, image: UIImage) {
        worker.saveCoreDataModels(id: id, name: name, image: image)
    }
    
    func deleteCoreDataModel(id: Int) {
        worker.deleteCoreDataModels(officeId:id)
    }
    
    func getCoreData() {
        worker.getCoreData { response in
            switch response {
            case .success(let coreData):
                self.presenter?.getCoreData(officesId: coreData)
            case .failure(let error):
                self.presenter?.alert(AlertMessage: error.localizedDescription)
            }
        }
    }
}
