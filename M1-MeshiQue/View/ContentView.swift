//
//  ContentView.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/09.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            BattleView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 1080, height: 810))
    }
}
