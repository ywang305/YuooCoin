//
//  KLine.swift
//  YuooCoin
//
//  Created by Yao Wang on 4/14/21.
//

import Foundation

struct KLine: Codable {
    let openTime: Int
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
    let closeTime: Int
}

// {"openTime":1618418940000,"open":"63573.23000000","high":"63680.00000000","low":"63573.23000000","close":"63626.25000000","volume":"51.31079200","closeTime":1618418999999}
