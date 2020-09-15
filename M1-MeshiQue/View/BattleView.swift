//
//  BattleView.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/15.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct BattleView: View {
    var back_img_name: String = "background"
    var monster01_name: String = "monster01"
    var monster02_name: String = "monster02"
    var monster03_name: String = "monster03"
    @State var arrow: [Bool] = [true, false, false]
    var body: some View {
        ZStack{
            Image(back_img_name)
                .resizable()
                .scaledToFill()
                .frame(width: 1080, height: 810)
            VStack {
                Spacer()
                HStack {
                    VStack {
                        if arrow[0] {
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                        }
                        Button(action: {self.arrow = [true, false, false]}){
                            MonsterView(monster_name: monster01_name, hpValue: 100)
                        }
                    }
                    VStack {
                        if arrow[1] {
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                        }
                        Button(action: {self.arrow = [false, true, false]}){
                            MonsterView(monster_name: monster02_name, hpValue: 70)
                        }
                    }
                    VStack {
                        if arrow[2] {
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                        }
                        Button(action: {self.arrow = [false, false, true]}){
                            MonsterView(monster_name: monster03_name, hpValue: 50)
                        }
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        Text("こめ")
                            .font(.custom("DragonQuestFC", size: 65))
                            .foregroundColor(.white)
                        Text("にく")
                            .font(.custom("DragonQuestFC", size: 65))
                            .foregroundColor(.white)
                        Text("さかな")
                            .font(.custom("DragonQuestFC", size: 65))
                            .foregroundColor(.white)
                        Text("やさい")
                            .font(.custom("DragonQuestFC", size: 65))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(width:200, height: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black)
                            .border(Color.white, width: 5)
                            .cornerRadius(5))
                    .frame(width:200, height: 300)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .frame(width:830, height: 300)
                        .border(Color.white, width: 5)
                        .cornerRadius(5)
                }
                .padding(15)
            }
        }
    }
}

struct BattleView_Previews: PreviewProvider {
    static var previews: some View {
        BattleView().previewLayout(.fixed(width: 1080, height: 810))
    }
}
