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
    @Published var enemyList: [Enemy] = []
    
    init(){
        enemeySetUp()
    }
    
    func enemeySetUp(){
        let name1 = monster_img_list.randomElement()!
        let name2 = monster_img_list.randomElement()!
        let name3 = monster_img_list.randomElement()!
        self.enemyList.append(Enemy(name: name1))
        self.enemyList.append(Enemy(name: name2))
        self.enemyList.append(Enemy(name: name3))
    }
}
