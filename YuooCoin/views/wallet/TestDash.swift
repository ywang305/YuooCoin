//
//  TestDash.swift
//  YuooCoin
//
//  Created by Yao Wang on 5/11/21.
//

import SwiftUI

struct TestDash: View {
    @State private var depositPassword = ""
    @State private var numberOfWallet = ""
    
    var body: some View {
        VStack{
            HStack{
                TextField("存币钱包密码", text: $depositPassword)
                TextField("创建数量", text: $numberOfWallet).keyboardType(.numberPad)
            }
            
        }
    }
}

struct TestDash_Previews: PreviewProvider {
    static var previews: some View {
        TestDash()
    }
}
