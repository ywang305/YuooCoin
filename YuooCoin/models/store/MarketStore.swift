//
//  ExchangeInfoStore.swift
//  YuooCoin
//
//  Created by Yao Wang on 3/25/21.
//


import UIKit
import Combine

class MarketStore : ObservableObject {
    @Published var symbolDict = [String : ExchangePair]()
    @Published var tickers:[MarketTicker]=[]
    @Published var stats: [Stat] = []
    
    init() {
        self.getExchangePair()
        self.subscribeToBinanceTicker()
        //self.getStat()
    }
    
    private func getExchangePair() {
        guard let url = URL(string: "http://34.238.234.55/exchangeInfo/pairs") else { return }
        NetworkManager.loadData(url: url){ [self] (data: [ExchangePair]) in
            data.forEach{
                symbolDict[$0.coin + $0.baseCoin]=$0
            }
        }
    }
    private func getStat() {
        guard let url = URL(string: "https://api.binance.com/api/v3/ticker/24hr") else {return}
        NetworkManager.loadData(url: url){ [self] (data: [Stat]) in
            stats = data
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
