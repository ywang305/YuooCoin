//
//  ExchangeInfoStore.swift
//  YuooCoin
//
//  Created by Yao Wang on 3/25/21.
//


import UIKit
import Combine

class MarketStore : ObservableObject {
    @Published var products = [Product]()
    @Published var symbols = Set<Symbol>()
    @Published var tickers:[MarketTicker]=[] {
        didSet {
            self.wsm?.readMessageOnce { [self] (rcvTickers: [MarketTicker]) in
                let sorted = rcvTickers.sorted { (t1, t2) in
                    return t1.n > t2.n  // by trade
                }
                for ticker in sorted {
                    if let found = self.symbols.first(where: {$0.symbol==ticker.s}) {
                        ticker.symbol = found.baseAsset+"-"+found.quoteAsset
                    }
                }
                tickers = sorted.filter{$0.symbol != nil}
            }
            
        }
    }
    private var wsm : WebSocketManager?
    
    init() {
        self.getBinanceExchangeInfo()
        self.getCoinbaseProducts()
        //self.subscribeToBinanceTicker()
        self.wsm = self.subToBinanceTicker()
    }
    
    private func getBinanceExchangeInfo() {
        guard let url = URL(string: "https://api.binance.com/api/v3/exchangeInfo") else { return }
        NetworkManager.loadData(url: url){ (data: ExchangeInfo) in
            DispatchQueue.main.async {
                self.symbols = Set(data.symbols)
            }
        }
    }
    private func getCoinbaseProducts() {
        guard let url = URL(string: "https://api.pro.coinbase.com/products") else { return }
        NetworkManager.loadData(url: url){ (data: [Product]) in
            DispatchQueue.main.async {
                self.products = data
            }
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
    
    func subToBinanceTicker() -> WebSocketManager? {
        guard let url = URL(string: "wss://stream.binance.com:9443/ws/!ticker@arr") else { return nil }
        let wsm = WebSocketManager()
        let success = wsm.connect(url: url)
        if(success) {
            wsm.readMessageOnce { [self] (rcvTickers: [MarketTicker]) in
                let sorted = rcvTickers.sorted { (t1, t2) in
                    return t1.n > t2.n  // by trade
                }
                for ticker in sorted {
                    if let found = self.symbols.first(where: {$0.symbol==ticker.s}) {
                        ticker.symbol = found.baseAsset+"-"+found.quoteAsset
                    }
                }
                tickers = sorted.filter{$0.symbol != nil}
            }
            return wsm
        }
        return nil
    }
}
