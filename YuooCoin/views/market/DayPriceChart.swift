//
//  DayChart.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/1/21.
//

import SwiftUI

struct DayPriceChart: View {
    
    var symbol = "ETHUSDT"
    var granularity = 3600
    @State var priceList = [Double]()
    
    private var color: Color {
        if let firstElement = priceList.first, let lastElement = priceList.last {
            return firstElement > lastElement ? .red : .green
        }
        return .black
    }
    
    var body: some View {
        LineChart(data: priceList, color: color).onAppear {
            guard let url = URL(string: "http://34.238.234.55/klines?symbol=\(symbol)&interval=1m") else {return}
            NetworkManager.loadData(url: url) { (data: [KLine]) in
                print(data)
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
