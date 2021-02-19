//
//  Product.swift
//  YuooCoin
//
//  Created by Yao Wang on 2/18/21.
//

import Foundation

struct Product : Codable {
    let id: String
    let display_name: String
    let base_currency: String
    let quote_currency: String
    let base_increment: String
    let quote_increment: String
    let base_min_size: String
    let base_max_size: String
    let min_market_finds: String
    let max_market_finds: String
    let status: String
    let status_message: String
    let cancel_only: Bool
    let limit_only: Bool
    let post_only: Bool
    let trading_disabled: Bool
}
