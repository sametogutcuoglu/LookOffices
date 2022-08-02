//
//  WebServices.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 1.08.2022.
//

import Foundation



//class WebServices : APIOfficeProtocol {
//    func getFecthOffice(url : URL, complation : @escaping ([Office]?) -> () ) {
//
//        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                print("Error")
//            }
//            guard let data = data else {
//                return
//            }
//            let officesList = try? JSONDecoder().decode([Office].self, from: data)
//
//            if let officesList = officesList {
//                complation(officesList)
//            }
//        }
//        dataTask.resume()
//    }
//
//
//}
//
