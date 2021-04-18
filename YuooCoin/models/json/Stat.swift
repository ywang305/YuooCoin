//
//  File.swift
//  YuooCoin
//
//  Created by Yao Wang on 4/18/21.
//

import Foundation

struct Stat : Codable {
    let symbol: String
    let priceChange: String
    let priceChangePercent: String
    let weightedAvgPrice: String
    let prevClosePrice: String
    let lastPrice: String
    let lastQty: String
    let bidPrice: String
    let askPrice: String
    let openPrice: String
    let highPrice: String
    let lowPrice: String
    let volume: String
    let quoteVolume: String
    let openTime: Int
    let closeTime: Int
    let firstId: Int   // First tradeId
    let lastId: Int    // Last tradeId
    let count: Int     // Trade count
}

