//
//  Trade.swift
//  YuooCoin
//
//  Created by Yao Wang on 4/19/21.
//
import WebKit
import SwiftUI

struct Trade: View {
    var pair = "BTC_USDT"
    var body: some View {
        WebViewer("https://www.binance.com/en/trade/\(pair)")
    }
}

struct Trade_Previews: PreviewProvider {
    static var previews: some View {
        Trade()
    }
}



struct WebViewer: UIViewRepresentable {
    
    let url : String
    init (_ url: String = "https://www.apple.com") {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
