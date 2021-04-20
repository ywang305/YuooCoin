//
//  TickerBoard.swift
//  YuooCoin
//
//  Created by Yao Wang on 1/30/21.
//

import SwiftUI

struct TickerBoard: View {
    @ObservedObject var marketStore = MarketStore()
    
    private var tickers: [MarketTicker] {
        marketStore.tickers
    }
    private var symbolDict: [String : ExchangePair] {
        marketStore.symbolDict
    }
    
    
    
    var body: some View {
        NavigationView {
            List(tickers, id: \.s) { ticker in
                if let pair = symbolDict[ticker.s] {
                    NavigationLink( destination: Trade(pair: "\(pair.coin)_\(pair.baseCoin)")) {
                        TickerItem( dispSymbol: pair.coin+"/"+pair.baseCoin,
                                    price: ticker.c,
                                    volume: String(ticker.n)
                                    )
                    }
                }
                
                
            }
        }
    }
}

struct TickerBoard_Previews: PreviewProvider {
    static var previews: some View {
        TickerBoard()
    }
}
