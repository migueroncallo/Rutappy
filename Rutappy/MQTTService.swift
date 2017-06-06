//
//  MQTTService.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/11/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import Foundation
import SwiftMQTT

class MQTTService{
    
    static let sharedInstance = MQTTService()
    
    let mqttSession = MQTTSession(host: "45.55.224.158", port: 1883, clientID: "rutappyriderios", cleanSession: true, keepAlive: 0)
    
    
}
