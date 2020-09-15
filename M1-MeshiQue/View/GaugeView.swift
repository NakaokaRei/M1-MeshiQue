//
//  GaugeView.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/16.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct GaugeView: View {
    @State var value: Int = 100
    var body: some View {
        ZStack{
            Capsule()
                .frame(width: 100, height: 10)
                .foregroundColor(.white)
            // red var
            Capsule()
                .position(x: 50, y:5)
                .frame(width: CGFloat(value), height: 10)
                .foregroundColor(.red)
        }
    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeView()
    }
}
