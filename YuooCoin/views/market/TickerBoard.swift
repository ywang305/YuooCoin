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
    
    var body: some View {
        NavigationView {
            List(tickers, id: \.s) { ticker in
                HStack {
                    Text(ticker.symbol ?? ticker.s).frame(width: 100, height: 30, alignment: .leading)
                    Spacer()
                    DayLineChart(symbol: ticker.symbol ?? "").frame(width: 70, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text(ticker.c).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: .leading)
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
