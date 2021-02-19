//
//  TickerBoard.swift
//  YuooCoin
//
//  Created by Yao Wang on 1/30/21.
//

import SwiftUI

struct TickerBoard: View {
    @ObservedObject var productsStore = ProductsStore()
    @State var tickers:[MarketTicker]=[]
    
    private func useWebsocket() {
        print("initing")
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
    
    var body: some View {
        NavigationView {
            List(tickers, id: \.s) { ticker in
                
                HStack {
                    Text(ticker.s).frame(width: 100, height: 30, alignment: .leading)
                    Spacer()
                    DayLineChart().frame(width: 60, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text(ticker.c).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: .leading)
                }
                
            }
        }.onAppear(perform: useWebsocket)
    }
}

struct TickerBoard_Previews: PreviewProvider {
    static var previews: some View {
        TickerBoard()
    }
}
