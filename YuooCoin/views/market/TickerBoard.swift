//
//  TickerBoard.swift
//  YuooCoin
//
//  Created by Yao Wang on 1/30/21.
//

import SwiftUI

struct TickerBoard: View {
    @ObservedObject var marketStore = MarketStore()
    
    private var tickerDict: [String: MarketTicker] {
        var dict = [String:MarketTicker]()
        marketStore.tickers.forEach{ dict[$0.s]=$0 }
        return dict
    }
    
    private var symbolInfos: [SymbolInfo] {
        marketStore.pairs.map{ pair in
            let coin = pair.coin
            let base = pair.baseCoin
            let found = tickerDict[coin+base]
            return SymbolInfo(
                id: coin+base,
                    dispSymbol: coin+"/"+base,
                    tradePair: coin+"_"+base,
                    price: found?.c ?? "",
                    volume: found?.n ?? 0)
        }.sorted{ $0.volume > $1.volume  }
    }
    
    
    var body: some View {
        NavigationView {
            List(symbolInfos) { info in
                NavigationLink(destination: Trade(pair: info.tradePair)) {
                    TickerItem (dispSymbol: info.dispSymbol,
                                price: info.price,
                                volume: String(info.volume))
                }
            }
        }
    }
}

private struct SymbolInfo : Identifiable {
    let id: String
    let dispSymbol: String
    let tradePair: String
    let price: String
    let volume: Int
}

struct TickerBoard_Previews: PreviewProvider {
    static var previews: some View {
        TickerBoard()
    }
}
