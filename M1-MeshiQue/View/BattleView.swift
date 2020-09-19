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
    @EnvironmentObject var meshiqueViewModel: MeshiQueViewModel
    
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
                        if meshiqueViewModel.selectedMonster == 0 {
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                        }
                        Button(action: {self.meshiqueViewModel.selectedMonster = 0}){
                            MonsterView(monster: self.$meshiqueViewModel.monsterList[0])
                        }
                    }
                    VStack {
                        if meshiqueViewModel.selectedMonster == 1 {
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                        }
                        Button(action: {self.meshiqueViewModel.selectedMonster = 1}){
                            MonsterView(monster: self.$meshiqueViewModel.monsterList[1])
                        }
                    }
                    VStack {
                        if meshiqueViewModel.selectedMonster == 2 {
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                        }
                        Button(action: {self.meshiqueViewModel.selectedMonster = 2}){
                            MonsterView(monster: self.$meshiqueViewModel.monsterList[2])
                        }
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        Button(action: {self.meshiqueViewModel.heroAttak(selectedSkill: 0)}){
                            Text("こめ")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                        }
                        Button(action: {self.meshiqueViewModel.heroAttak(selectedSkill: 1)}){
                            Text("たまご")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                        }
                        Button(action: {self.meshiqueViewModel.heroAttak(selectedSkill: 2)}){
                            Text("さかな")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                        }
                        Button(action: {self.meshiqueViewModel.heroAttak(selectedSkill: 3)}){
                            Text("やさい")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: {self.meshiqueViewModel.startFlag = false}){
                            Text("リタイア")
                                .font(.custom("DragonQuestFC", size: 50))
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .frame(width:200, height: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black)
                            .border(Color.white, width: 5)
                            .cornerRadius(5))
                    .frame(width:200, height: 300)
                    VStack{
                        HeroGaugeView(value: meshiqueViewModel.hero.hpValue)
                            .offset(x: -230, y: -60)
                        Text("てきがこうげきしてきた")
                            .font(.custom("DragonQuestFC", size: 80))
                            .foregroundColor(.white)
                    }
                    .frame(width:830, height: 300)
                    .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .border(Color.white, width: 5)
                        .cornerRadius(5))
                }
                .padding(15)
            }
        }
    }
}

struct BattleView_Previews: PreviewProvider {
    static var previews: some View {
        BattleView().previewLayout(.fixed(width: 1080, height: 810)).environmentObject(MeshiQueViewModel())
    }
}
