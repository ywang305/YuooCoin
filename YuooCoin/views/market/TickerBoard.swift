//
//  TickerBoard.swift
//  YuooCoin
//
//  Created by Yao Wang on 1/30/21.
//

import SwiftUI

struct TickerBoard: View {
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
                    Text(ticker.s)
                    Spacer()
                    Text(ticker.c)
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
