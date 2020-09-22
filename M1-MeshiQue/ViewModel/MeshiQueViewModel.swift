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
import AVFoundation

class MeshiQueViewModel: NSObject, ObservableObject {
    @Published var monsterList: [Monster] = [Monster(), Monster(), Monster()]
    @Published var startFlag: Bool = false
    @Published var selectedMonster: Int = 0
    @Published var hero: Hero = Hero()
    @Published var showAlert: Bool = false
    @Published var message: String = "てきがあらわれた"
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    var bgmPlayer: AVAudioPlayer!
    var sePlayer: AVAudioPlayer!
    var ipAddress: String = "163.221.128.44:5000"
    var underAttack: Bool = false
    var clearOrOver: String = ""
    
    override init() {
        super.init()
        bgmPlaySound(name: "bgm_opening")
    }
    
    func start(){
        startFlag = true
        bgmPlaySound(name: "bgm_battle1")
        enemeySetUp()
        heroSetUp()
        connect()
    }
    
    func escape(){
        if [true, false].randomElement()! && !underAttack{
            startFlag = false
            sePlaySound(name: "se_escape")
            bgmPlaySound(name: "bgm_opening")
        } else if !underAttack {
            underAttack = true
            message = "にげれなかった！！"
            monsterAttack()
        }
    }
    
    func connect(){
        manager = SocketManager(socketURL: URL(string: "http://" + ipAddress)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { data, ack in
            print("connect")
        }
        
        socket.on("from_chopstick") { data, ack in
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
    
    func heroSetUp(){
        hero = Hero()
    }
    
    // 主人公側の攻撃
    func heroAttak(selectedSkill: Int){
        if !underAttack && hero.hpValue > 0 {
            underAttack = true
            message = skill_list[selectedSkill]
            self.sePlaySound(name: "se_heroAttack")
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
            if monsterList[0].hpValue==0 && monsterList[1].hpValue==0 && monsterList[2].hpValue==0 {
                clearOrOver = "clear"
                bgmPlaySound(name: "bgm_gameclear")
                showAlert = true
            }
            monsterAttack()
        }
    }
        
    // モンスターからの攻撃
    func monsterAttack(){
        DispatchQueue.global().async {
            for monster in self.monsterList {
                if monster.hpValue != 0 {
                    Thread.sleep(forTimeInterval: 0.7)
                    DispatchQueue.main.async() {
                        self.sePlaySound(name: "se_monsterAttack")
                        let damage_monster = monster.attack()
                        self.message = "ダメージをうけた！！"
                        if self.hero.hpValue >= damage_monster {
                            self.hero.hpValue -= damage_monster
                            if self.hero.hpValue == 0 {
                                self.clearOrOver = "over"
                                self.bgmPlaySound(name: "bgm_gameover")
                                self.showAlert = true
                                self.objectWillChange.send()
                            }
                            self.objectWillChange.send()
                        } else if self.hero.hpValue < damage_monster {
                            self.hero.hpValue = 0
                            self.clearOrOver = "over"
                            self.bgmPlaySound(name: "bgm_gameover")
                            self.showAlert = true
                            self.objectWillChange.send()
                        }
                    }
                }
            }
            self.underAttack = false
        }
    }
}

extension MeshiQueViewModel: AVAudioPlayerDelegate {
    func bgmPlaySound(name: String, loopNum: Int = -1) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        do {
            // AVAudioPlayerのインスタンス化
            bgmPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            bgmPlayer.delegate = self
            // 音声の再生
            bgmPlayer.volume = 0.5
            bgmPlayer.numberOfLoops = loopNum
            bgmPlayer.play()
        } catch {
            print("Error")
        }
    }
    
    func sePlaySound(name: String, loopNum: Int = 1) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        do {
            // AVAudioPlayerのインスタンス化
            sePlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            sePlayer.delegate = self
            // 音声の再生
            sePlayer.volume = 1.0
            sePlayer.numberOfLoops = loopNum
            sePlayer.play()
        } catch {
            print("Error")
        }
    }
}
