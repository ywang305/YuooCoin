//
//  DayChart.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/1/21.
//

import SwiftUI

struct DayPriceChart: View {
    var symbol = "BTC-USD"
    var granularity = 3600
    @State var priceList = [Double]()
    
    
    var body: some View {
        LineChart(data: priceList).onAppear {
//            guard let cbp_candle = URL(string: "https://api.pro.coinbase.com/products/\(symbol)/candles?granularity=\(granularity)") else { return }
//            NetworkManager.loadData(url: cbp_candle) { (data: [[Double]]) in
//                let closeList = data.map{ $0[4] }
//                priceList = closeList
//            }
            
            guard let bi_kline = URL(string: "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=30m") else {return}
            NetworkManager.loadData(url: bi_kline) { (data: [[String?]]) in
                priceList = data.map{ Double($0[4] ?? "") ?? 0 }
            }
        }
    }
}

struct DayPriceChart_Previews: PreviewProvider {
    static var previews: some View {
        DayPriceChart()
    }
}
