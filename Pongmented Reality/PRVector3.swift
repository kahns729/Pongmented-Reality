//
//  PRVector3.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit

public func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
}

public func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x - right.x, left.y - right.y, left.z - right.z)
}

extension SCNVector3 {
    func trunc(threshold: SCNVector3 = SCNVector3(0, 0, 0), dampen: Float = 1.0) -> SCNVector3 {
        var truncVector3 = SCNVector3(0, 0, 0)
        if abs(self.x) >= threshold.x {
            truncVector3.x = dampen * self.x
        }
        if abs(self.y) >= threshold.y {
            truncVector3.y = dampen * self.y
        }
        if abs(self.z) >= threshold.z {
            truncVector3.z = dampen * self.z
        }
        return truncVector3
    }
    
    func scale(_ factor: Float) -> SCNVector3 {
        return SCNVector3(self.x * factor, self.y * factor, self.z * factor)
    }
}
