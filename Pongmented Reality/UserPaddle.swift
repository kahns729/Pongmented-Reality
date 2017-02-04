//
//  UserPaddle.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit

//let ACCEL_TRUNC_THRESHOLD = SCNVector3(x: 0.000001, y: 0.000001, z: 0.000001)
let ACCEL_TRUNC_THRESHOLD = SCNVector3(x: 0.02, y: 0.02, z: 0.02)
let ACCEL_DAMPEN_FACTOR : Float = 0.05

//let VELOC_TRUNC_THRESHOLD = SCNVector3(x: 0.0002, y: 0.0002, z: 0.0002)
let VELOC_TRUNC_THRESHOLD = SCNVector3(x: 0.02, y: 0.02, z: 0.02)
let VELOC_DAMPEN_FACTOR : Float = 1

let ORIGIN = SCNVector3(x: 0, y: 0, z: -1)
let ACCEL_HISTORY_LEN = 5

class UserPaddle: SCNNode {
    var velocity : SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    var consecutiveZeroes : Int = 0
//    var accelHistory : Queue<SCNVector3> = Queue()
    
    override init() {
        super.init()
        self.geometry = SCNBox(width: 0.5, height: 0.3, length: 0.05, chamferRadius: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func accelerate(accel : SCNVector3) {
        var trueAccel = accel.trunc(threshold: ACCEL_TRUNC_THRESHOLD, dampen: ACCEL_DAMPEN_FACTOR)
        if trueAccel.x == 0.0 && trueAccel.y == 0.0 && trueAccel.z == 0.0 {
            consecutiveZeroes += 1
            if consecutiveZeroes >= ACCEL_HISTORY_LEN {
                self.velocity = SCNVector3(0, 0, 0)
            }
        } else {
            consecutiveZeroes = 0
            trueAccel.x = -1.0 * trueAccel.x
            self.velocity = (self.velocity + trueAccel).trunc(threshold: VELOC_TRUNC_THRESHOLD)
        }
//        trueAccel.x = -1.0 * trueAccel.x
//        self.velocity = (self.velocity + trueAccel).trunc(threshold: VELOC_TRUNC_THRESHOLD)
//        print("Velocity: \(self.velocity)\nAcceleration: \(accel)\n")
//        self.velocity = trueAccel
//        accelHistory.push(trueAccel)
    }
    
    func updatePosition() {
        self.position = self.position + self.velocity
    }
    
    func snapToOrigin() {
        self.position = ORIGIN
    }
}
