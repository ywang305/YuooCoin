//
//  DayChart.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/1/21.
//

import SwiftUI
import SwiftUICharts

struct DayLineChart: View {
    @State var priceList = [Double]()
    
    
    var body: some View {
        GeometryReader { geometry in
            SwiftUICharts.LineView(data: priceList).onAppear {
                guard let url = URL(string: "https://api.pro.coinbase.com/products/BTC-USD/candles?granularity=3600") else { return }
                
                NetworkManager.loadData(url: url) { (data: [[Double]]) in
                    let closeList = data.map{ $0[4] }
                    priceList = closeList
                }
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        
    }
}

struct DayLineChart_Previews: PreviewProvider {
    static var previews: some View {
        DayLineChart()
    }
}
