//
//  UserPaddle.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit

let ACCEL_TRUNC_THRESHOLD = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
let ACCEL_STOP_THRESHOLD = SCNVector3(x: 0.02, y: 0.02, z: 0.02)
//let ACCEL_TRUNC_THRESHOLD = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
let ACCEL_DAMPEN_FACTOR : Float = 0.02

//let VELOC_TRUNC_THRESHOLD = SCNVector3(x: 0.0002, y: 0.0002, z: 0.0002)
let VELOC_TRUNC_THRESHOLD = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
let VELOC_DAMPEN_FACTOR : Float = 1

let ORIGIN = SCNVector3(x: 0, y: 0, z: 0)
let ACCEL_HISTORY_LEN = 8
//let ACCEL_HISTORY_STOP = 3
//let ACCEL_HISTORY_SNAP = 5

func weightedAverage(_ accelQueue : Queue<SCNVector3>) -> SCNVector3 {
    var index = 1
    var divisor : Float = 0.0
    var result = SCNVector3(0, 0, 0)
    var iterator = accelQueue.head
    while iterator != nil {
        let weight = pow(Float(index), 3.0)
        result = result + iterator!.data.scale(weight)
        divisor += weight
        iterator = iterator!.next
        index += 1
    }
    return result.scale(1.0 / divisor)
}

fileprivate struct Bounds {
    typealias Bound = (lower: Float, upper: Float)
    let x: Bound = (-3, 3)
    let y: Bound = (-3, 3)
}

class UserPaddle: SCNNode {
    var velocity : SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    var accelHistory = Queue<SCNVector3>()
    private let bounds = Bounds()
    
    override init() {
        super.init()
        self.geometry = SCNBox(width: 0.5, height: 0.3, length: 0.05, chamferRadius: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func accelerate(accel : SCNVector3) {
        var trueAccel = accel
        trueAccel.x = -1.0 * accel.x
        trueAccel.z = 0
        accelHistory.push(accel)
        if accelHistory.len > ACCEL_HISTORY_LEN {
            accelHistory.pop()
        }
        self.velocity = self.velocity + weightedAverage(accelHistory).scale(ACCEL_DAMPEN_FACTOR)
    }
    
    func updatePosition() {
        self.position = self.position + self.velocity
        
        if self.position.x < bounds.x.lower {
            self.position.x = bounds.x.lower
            self.velocity.x = 0
            accelHistory.clear()
        }
        if self.position.y < bounds.y.lower {
            self.position.y = bounds.y.lower
            self.velocity.y = 0
            accelHistory.clear()
        }
        
        if self.position.x > bounds.x.upper {
            self.position.x = bounds.x.upper
            self.velocity.x = 0
            accelHistory.clear()
        }
        if self.position.y > bounds.y.upper {
            self.position.y = bounds.y.upper
            self.velocity.y = 0
            accelHistory.clear()
        }
    }
}
