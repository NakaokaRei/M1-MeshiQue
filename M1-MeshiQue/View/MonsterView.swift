//
//  MonsterView.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/16.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct MonsterView: View {
    var monster: Monster = Monster()
    var hpValue: Int = 50
    var body: some View {
        VStack {
            Image(monster.name)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 270, height: 270)
                .padding(15)
            GaugeView(value: monster.hpValue)
        }
    }
}

struct MonsterView_Previews: PreviewProvider {
    static var previews: some View {
        MonsterView()
    }
}
