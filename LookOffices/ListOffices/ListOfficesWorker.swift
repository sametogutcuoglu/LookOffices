//
//  ListOfficesWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesWorkingLogic: AnyObject {}

protocol APIOfficeProtocol {
    func getFetchOffice(url: URL, complation: @escaping ([Office]?,_ error:String) -> Void)
}

final class ListOfficesWorker: ListOfficesWorkingLogic, APIOfficeProtocol {
    func getFetchOffice(url: URL, complation: @escaping ([Office]?,_ error:String) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                complation(nil, AppConstants.error)
            }
            guard let data = data else {
                return
            }
            let officesList = try? JSONDecoder().decode([Office].self, from: data)

            if let officesList = officesList {
                complation(officesList, AppConstants.error)
            }
        }
        dataTask.resume()
    }
}
