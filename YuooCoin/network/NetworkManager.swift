//
//  NetworkManager.swift
//  CryptExchange
//
//  Created by Yao Wang on 1/25/21.
//

import UIKit

class NetworkManager {
    static func loadData<T:Codable>(url: URL, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let response = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }.resume()
    }
    
    
}
