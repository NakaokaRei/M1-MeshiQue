//
//  OpeningView.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/16.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct OpeningView: View {
    @EnvironmentObject var meshiqueViewModel: MeshiQueViewModel
    var body: some View {
        VStack {
            Text("メシクエ")
                .font(.custom("DragonQuestFC", size: 350))
                .offset(y: -80)

            TextField("IPアドレスを入力してね", text: $meshiqueViewModel.ipAddress)
                .frame(width: 200,  height: 50)
                .textFieldStyle(
                    RoundedBorderTextFieldStyle())
                .offset(y: -100)
            
            Button(action: {self.meshiqueViewModel.start()}){
                Text("スタート")
                    .font(.custom("DragonQuestFC", size: 100))
            }
            Spacer()
        }
    }
}

struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView().previewLayout(.fixed(width: 1080, height: 810)).environmentObject(MeshiQueViewModel())
    }
}
