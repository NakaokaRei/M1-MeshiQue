//
//  SocketSignal.swift
//  M1-MeshiQue
//
//  Created by 中岡黎 on 2020/09/23.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation
import SocketIO

class SocketSignal {
    var manager: SocketManager!
    var socket: SocketIOClient!
    var delegate: SocketProtocol!
    var ipAddress: String!
    
    func connect() {
        manager = SocketManager(socketURL: URL(string: "http://" + ipAddress)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { data, ack in
            print("connect")
        }
        
        socket.on("from_chopstick") { data, ack in
            self.delegate.heroAttack(selectedSkill: data[0] as! Int)
        }
        
        socket.connect()
    }
    
    func disConnect(){
        socket.disconnect()
    }
}
