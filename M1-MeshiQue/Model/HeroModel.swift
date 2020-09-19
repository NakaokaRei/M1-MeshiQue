//
//  HeroModel.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/19.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation

class Hero {
    var hpValue: Int
    var skills: [Int] = [10 ,30, 50, 70]
    
    init(hpValue: Int = 300){
        self.hpValue = hpValue
    }
    
    func attack() -> Int{
        let damage = skills.randomElement()!
        return damage
    }
    
}
