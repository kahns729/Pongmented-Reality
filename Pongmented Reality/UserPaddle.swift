//
//  UserPaddle.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit

let TRUNC_THRESHOLD = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
let DAMPEN_FACTOR = 0.005

class UserPaddle: SCNNode {
    var velocity : SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    
    override init() {
        super.init()
        self.geometry = SCNBox(width: 0.5, height: 0.3, length: 0.05, chamferRadius: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func accelerate(accel : SCNVector3) {
        let trueAccel = accel.trunc(threshold: TRUNC_THRESHOLD, dampen: DAMPEN_FACTOR)
//        if trueAccel.x == 0 && trueAccel.y == 0 && trueAccel.z == 0 {
//            self.velocity = SCNVector3(x: 0, y: 0, z: 0)
//        } else {
            self.velocity = self.velocity + trueAccel
//        }
    }
    
    func updatePosition() {
        self.position = self.position + self.velocity
    }
}
