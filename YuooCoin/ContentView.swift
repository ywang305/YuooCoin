//
//  ContentView.swift
//  YuooCoin
//
//  Created by Yao Wang on 1/30/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding().onAppear {
                guard let url = URL(string: "wss://stream.binance.com:9443/ws/!ticker@arr") else { return }
                WebSocketManager.shared.connect(url: url)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
