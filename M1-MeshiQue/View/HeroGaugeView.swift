//
//  HeroGaugeView.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/19.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct HeroGaugeView: View {
    @State var value: Int = 200
    var body: some View {
        ZStack{
            Capsule()
                .frame(width: 300, height: 20)
                .foregroundColor(.white)
            // red var
            Capsule()
                .position(x: 150, y:10)
                .frame(width: CGFloat(value), height: 20)
                .foregroundColor(.red)
        }
    }
}

struct HeroGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        HeroGaugeView()
    }
}
