//
//  MeshiQueViewModel.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/19.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation
import Combine
import SocketIO

class MeshiQueViewModel: ObservableObject {
    @Published var monsterList: [Monster] = [Monster(), Monster(), Monster()]
    @Published var startFlag: Bool = false
    @Published var selectedMonster: Int = 0
    @Published var hero: Hero = Hero()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    var ipAddress: String = "163.221.128.44:5000"
    
    func start(){
        startFlag = true
        enemeySetUp()
        connect()
    }
    
    func connect(){
        manager = SocketManager(socketURL: URL(string: "http://" + ipAddress)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { data, ack in
            print("connect")
        }
        
        socket.on("from_chopstick") { data, ack in
            //debug
            //print(type(of: data[0] as! Int))
            self.heroAttak(selectedSkill: data[0] as! Int)
        }
        socket.connect()
    }
    
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
