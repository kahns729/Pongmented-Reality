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

extension SCNVector3 {
    func trunc(threshold: SCNVector3, dampen: Double?) -> SCNVector3 {
        var truncVector3 = SCNVector3(0, 0, 0)
        if self.x >= threshold.x {
            truncVector3.x = self.x
        }
        if self.y >= threshold.y {
            truncVector3.y = self.y
        }
        if self.z >= threshold.z {
            truncVector3.z = self.z
        }
        return truncVector3
    }
}
