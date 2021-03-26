//
//  ExchangeInfoStore.swift
//  YuooCoin
//
//  Created by Yao Wang on 3/25/21.
//


import UIKit
import Combine

class MarketStore : ObservableObject {
    @Published var exchangeInfo : ExchangeInfo?
    @Published var products = [Product]()
    
    init() {
        self.getBinanceExchangeInfo()
        self.getCoinbaseProducts()
    }
    
    func getBinanceExchangeInfo() {
        guard let url = URL(string: "https://api.binance.com/api/v3/exchangeInfo") else { return }
        NetworkManager.loadData(url: url){ (data: ExchangeInfo) in
            self.exchangeInfo = data
        }
    }
    func getCoinbaseProducts() {
        guard let url = URL(string: "https://api.pro.coinbase.com/products") else { return }
        NetworkManager.loadData(url: url){ (data: [Product]) in
            self.products = data
        }
    }
    
}
