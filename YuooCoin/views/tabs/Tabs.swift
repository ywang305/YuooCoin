//
//  SwiftUIView.swift
//  YuooCoin
//
//  Created by Yao Wang on 4/20/21.
//

import SwiftUI

struct Tabs: View {
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            TickerBoard()
                .tabItem { Image(systemName: "chart.bar").tag(1) }
            Text("2nd Tab Content")
                .tabItem { Image(systemName: "bitcoinsign.circle") }
                .tag(2)
            Text("user")
                .tabItem { Image(systemName: "person")
                    .tag(3)
                }
        }
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}
