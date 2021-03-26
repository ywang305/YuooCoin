//
//  ExchangeInfo.swift
//  YuooCoin
//
//  Created by Yao Wang on 3/25/21.
//

import Foundation

struct ExchangeInfo : Codable {
    let symbols: [Symbol]
}

struct Symbol: Codable {
    let symbol: String
    let baseAsset: String
    let quoteAsset: String
}

