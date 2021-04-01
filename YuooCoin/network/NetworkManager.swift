//
//  NetworkManager.swift
//  CryptExchange
//
//  Created by Yao Wang on 1/25/21.
//

import UIKit

class NetworkManager {
    private static var jsonDecoder = JSONDecoder()
    
    static func loadData<T:Codable>(url: URL, completion: @escaping (T) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            if let dto = try? jsonDecoder.decode(T.self, from: data) {
                completion(dto)
//                DispatchQueue.main.async {
//                    completion(dto)
//                }
            }
            
            
            
        }.resume()
    }
    
    
}
