//
//  TickerItem.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/13/21.
//

import SwiftUI

struct TickerItem: View {
    var symbol:String
    var price: String
    
    var body: some View {
        HStack {
            Text(symbol)
            Spacer()
            DayLineChart()
            Spacer()
            Text(price)
        }
    }
}

struct TickerItem_Previews: PreviewProvider {
    static var previews: some View {
        TickerItem(symbol: "BTC/USD", price: "20.012")
    }
}
