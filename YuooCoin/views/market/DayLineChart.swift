//
//  DayChart.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/1/21.
//

import SwiftUI

struct DayLineChart: View {
    var symbol = "BTC-USD"
    var granularity = 3600
    @State var priceList = [Double]()
    
    
    var body: some View {
        LineChart(data: priceList).onAppear {
            guard let url = URL(string: "https://api.pro.coinbase.com/products/\(symbol)/candles?granularity=\(granularity)") else { return }
            
            NetworkManager.loadData(url: url) { (data: [[Double]]) in
                let closeList = data.map{ $0[4] }
                priceList = closeList
            }
        }
    }
}

struct DayLineChart_Previews: PreviewProvider {
    static var previews: some View {
        DayLineChart()
    }
}
