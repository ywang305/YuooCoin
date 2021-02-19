//
//  Coins.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/18/21.
//

import UIKit
import Combine

class ProductsStore : ObservableObject {
    @Published var posts = [Product]()
    
    init() {
        getProducts()
    }
    
    func getProducts() {
        guard let url = URL(string: "https://api.pro.coinbase.com/products") else {
            return
        }
        
        NetworkManager.loadData(url: url){ (data: [Product]) in
            self.posts = data
        }
    }
}
