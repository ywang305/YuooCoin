//
//  DayChart.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/1/21.
//

import SwiftUI

struct DayPriceChart: View {
    var symbol = "BTCUSDT"
    var granularity = 3600
    @State var priceList = [Double]()
    
    
    var body: some View {
        LineChart(data: priceList).onAppear {
            guard let url = URL(string: "http://34.238.234.55/klines?symbol=\(symbol)&interval=1m") else {return}
            NetworkManager.loadData(url: url) { (data: [KLine]) in
                priceList = data.map{ Double($0.close) ?? 0 }
            }
        }
    }
}

struct DayPriceChart_Previews: PreviewProvider {
    static var previews: some View {
        DayPriceChart()
    }
}
