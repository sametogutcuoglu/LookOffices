//
//  ListOfficesWorker.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation

protocol ListOfficesWorkingLogic: AnyObject {
  
}
protocol APIOfficeProtocol {
    func getFecthOffice(url : URL, complation : @escaping ([Office]?) -> () )
}

final class ListOfficesWorker: ListOfficesWorkingLogic,APIOfficeProtocol {
    
    func getFecthOffice(url: URL, complation: @escaping ([Office]?) -> ()) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error")
                complation(nil)
            }
            guard let data = data else {
                return
            }
            let officesList = try? JSONDecoder().decode([Office].self, from: data)
            
            if let officesList = officesList {
                complation(officesList)
            }

        }
        dataTask.resume()
    }
    
    
}
