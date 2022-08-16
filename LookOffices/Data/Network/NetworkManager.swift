//
//  NetworkManager.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 8.08.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func getFetchOffice(complation: @escaping ((Result<[Office], Error>) -> Void))
}

struct NetworkManager : NetworkManagerProtocol {
    
    func getFetchOffice(complation: @escaping ((Result<[Office], Error>) -> Void)) {
        guard let url = URL(string: AppConstants.firebaseURL) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                complation(.failure(error ?? NSError(domain: "Unkown error", code: -1)))
                return
            }
            do {
                let officesList = try JSONDecoder().decode([Office].self, from: data)
                complation(.success((officesList)))
            }
               catch {
                     complation(.failure(NSError(domain: "decode Parse Error \(error)", code: -2)))
                }
         
        }
        dataTask.resume()
    }
}



