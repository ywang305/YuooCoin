//
//  ExchangeInfoStore.swift
//  YuooCoin
//
//  Created by Yao Wang on 3/25/21.
//


import UIKit
import Combine

class MarketStore : ObservableObject {
    @Published var exchangePairs = Set<ExchangePair>()
    @Published var tickers:[MarketTicker]=[]
    
    init() {
        self.getExchangePair()
        self.subscribeToBinanceTicker()
    }
    
    private func getExchangePair() {
        guard let url = URL(string: "http://34.238.234.55/exchangeInfo/pairs") else { return }
        NetworkManager.loadData(url: url){ (data: [ExchangePair]) in
            self.exchangePairs = Set(data)
        }
    }
    
    private func subscribeToBinanceTicker() {
        guard let url = URL(string: "wss://stream.binance.com:9443/ws/!ticker@arr") else { return }
        let success = WebSocketManager.shared.connect(url: url)
        if(success) {
            WebSocketManager.shared.readMessage{ [self] (rcvTickers: [MarketTicker]) in
                let sorted = rcvTickers.sorted { (t1, t2) in
                    return t1.n > t2.n  // by trade
                }
                tickers = sorted
            }
        }
    }
    
}
