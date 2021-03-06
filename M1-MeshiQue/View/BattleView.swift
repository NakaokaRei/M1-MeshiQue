//
//  BattleView.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/15.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct BattleView: View {
    @EnvironmentObject var meshiqueViewModel: MeshiQueViewModel
    
    var body: some View {
        ZStack{
            Image(meshiqueViewModel.backgroundImgName)
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
                        Button(action: {self.meshiqueViewModel.heroAttack(selectedSkill: 0)}){
                            if self.meshiqueViewModel.previousAttak == 0 {
                                Text("こめ")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.red)
                            } else {
                                Text("こめ")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                            }
                        }
                        Button(action: {self.meshiqueViewModel.heroAttack(selectedSkill: 1)}){
                            if self.meshiqueViewModel.previousAttak == 1 {
                                Text("たまご")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.red)
                            } else {
                                Text("たまご")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                            }
                        }
                        Button(action: {self.meshiqueViewModel.heroAttack(selectedSkill: 2)}){
                            if self.meshiqueViewModel.previousAttak == 2 {
                                Text("さかな")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.red)
                            } else {
                                Text("さかな")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                            }
                        }
                        Button(action: {self.meshiqueViewModel.heroAttack(selectedSkill: 3)}){
                            if self.meshiqueViewModel.previousAttak == 3 {
                                Text("やさい")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.red)
                            } else {
                                Text("やさい")
                                .font(.custom("DragonQuestFC", size: 55))
                                .foregroundColor(.white)
                            }
                        }
                        Spacer()
                        Button(action: {self.meshiqueViewModel.escape()}){
                            Text("にげる")
                                .font(.custom("DragonQuestFC", size: 50))
                                .foregroundColor(.white)
                                .offset(y: -7)
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
                        HStack {
                            Text("たいりょく")
                                .font(.custom("DragonQuestFC", size: 35))
                                .foregroundColor(.white)
                                .offset(y: -8)
                            HeroGaugeView(value: $meshiqueViewModel.hero.hpValue)
                        }
                            .offset(x: -190, y: -60)
                        Text(meshiqueViewModel.message)
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
        .alert(isPresented: $meshiqueViewModel.showAlert){
            switch(meshiqueViewModel.clearOrOver){
                case "over":
                    return Alert(title: Text("ゲームオーバー"),
                                 message: Text("スタート画面に戻ります"),
                                 dismissButton: .default(Text("わかりました"),
                                                         action: {self.meshiqueViewModel.goToOpening()}))
                case "clear":
                    return Alert(title: Text("ゲームクリア！！"),
                                 message: Text("スタート画面に戻ります"),
                                 dismissButton: .default(Text("わかりました"),
                                                         action: {self.meshiqueViewModel.goToOpening()}))
                case "next":
                    return Alert(title: Text("次はボス戦です！！"),
                                 message: Text("準備はできましたか？？"),
                                 dismissButton: .default(Text("できました"),
                                                         action: {self.meshiqueViewModel.nextStage()}))
                default:
                    return Alert(title: Text("Error"))
            }
        }
    }
}

struct BattleView_Previews: PreviewProvider {
    static var previews: some View {
        BattleView().previewLayout(.fixed(width: 1080, height: 810)).environmentObject(MeshiQueViewModel())
    }
}
