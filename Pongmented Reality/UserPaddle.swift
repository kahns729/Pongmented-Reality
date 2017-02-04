//
//  UserPaddle.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit

let ACCEL_TRUNC_THRESHOLD = SCNVector3(x: 0.0001, y: 0.0001, z: 0.0001)
let ACCEL_TRUNC_THRESHOLD = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
let ACCEL_DAMPEN_FACTOR : Float = 0.02

let VELOC_TRUNC_THRESHOLD = SCNVector3(x: 0.005, y: 0.005, z: 0.005)
let VELOC_DAMPEN_FACTOR : Float = 1

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
        var trueAccel = accel.trunc(threshold: ACCEL_TRUNC_THRESHOLD, dampen: ACCEL_DAMPEN_FACTOR)
        trueAccel.x = -1.0 * trueAccel.x
        self.velocity = (self.velocity + trueAccel).trunc(threshold: VELOC_TRUNC_THRESHOLD)
    }
    
    func updatePosition() {
        self.position = self.position + self.velocity
    }
}
