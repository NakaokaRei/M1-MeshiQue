//
//  MeshiQueViewModel.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/19.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation
import Combine

class MeshiQueViewModel: ObservableObject {
    @Published var monsterList: [Monster] = [Monster(), Monster(), Monster()]
    @Published var startFlag: Bool = false
    @Published var selectedMonster: Int = 0
    @Published var hero: Hero = Hero()
    
    func enemeySetUp(){
        monsterList = []
        let name1 = monster_img_list.randomElement()!
        let name2 = monster_img_list.randomElement()!
        let name3 = monster_img_list.randomElement()!
        self.monsterList.append(Monster(name: name1))
        self.monsterList.append(Monster(name: name2))
        self.monsterList.append(Monster(name: name3))
    }
    
    func heroAttak(selectedSkill: Int){
        let damage_hero = hero.attack(selecedSkill: selectedSkill)
        if monsterList[selectedMonster].hpValue >= damage_hero {
            monsterList[selectedMonster].hpValue -= damage_hero
            if monsterList[selectedMonster].hpValue == 0 {
                monsterList[selectedMonster].name = "batsu"
            }
            self.objectWillChange.send()
        } else if monsterList[selectedMonster].hpValue < damage_hero {
            monsterList[selectedMonster].hpValue = 0
            monsterList[selectedMonster].name = "batsu"
            self.objectWillChange.send()
        }
        
    }
}
