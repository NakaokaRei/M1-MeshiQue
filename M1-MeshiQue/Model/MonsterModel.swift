//
//  MonsterModel.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/20.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation

class Monster {
    var hpValue: Int
    var name: String
    var skills: [Int] = [10, 20, 30]
    
    init(hpValue: Int = 100, name: String = "monster01"){
        self.hpValue = hpValue
        self.name = name
    }
    
    func attack() -> Int{
        let damage = skills.randomElement()!
        return damage
    }
    
}
