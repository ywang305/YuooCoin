//
//  TickerItem.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/13/21.
//

import SwiftUI

struct TickerItem: View, Equatable {
    static func == (lhs: TickerItem, rhs: TickerItem) -> Bool {
        lhs.dispSymbol == rhs.dispSymbol
            && lhs.price == rhs.price &&
            lhs.volume == rhs.volume
    }
    
    var dispSymbol: String="BTC/USDT"
    var price: String="6000201.820934234"
    var volume: String = "90.000101000111101"
    
    @State private var priceList: [Double] = []
    
    private var symbol: String {
        dispSymbol.replacingOccurrences(of: "/", with: "")
    }
    private var priceChangePercentage: Double {
        if let first = priceList.first, let last = priceList.last {
            return (last-first)/first
        }
        return 0
    }
    private var color: Color {
        switch priceChangePercentage {
        case 0: return .black
        case ..<0: return .red
        default: return .green
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(dispSymbol)
                Text("vol. "+volume).foregroundColor(.gray)
            }.frame(width: 100).lineLimit(1)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(price)
                Text(String(format: "%.2f", priceChangePercentage*100)+"%").foregroundColor(color)
            }.frame(width: 100).lineLimit(1)
            
            Spacer()
            LineChart(data: priceList, color: color, lineWidth: 0.25)
        }.onAppear {
            guard let url = URL(string: "http://34.238.234.55/klines?symbol=\(symbol)&interval=1m") else {return}
            NetworkManager.loadData(url: url) { (data: [KLine]) in
                print(data)
                priceList = data.map{ Double($0.close) ?? 0 }
            }
        }
    }
    
}

struct TickerItem_Previews: PreviewProvider {
    static var previews: some View {
        TickerItem()
    }
}
