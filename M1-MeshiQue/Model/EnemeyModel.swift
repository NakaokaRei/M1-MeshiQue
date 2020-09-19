//
//  EnemeyModel.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/19.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation

class Enemy {
    var hpValue: Int
    var name: String
    var skills: [Int] = [30, 50, 70]
    
    init(hpValue: Int = 100, name: String = "monster01"){
        self.hpValue = hpValue
        self.name = name
    }
    
    func attack() -> Int{
        let damage = skills.randomElement()!
        return damage
    }
    
}
