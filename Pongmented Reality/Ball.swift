//
//  Ball.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit

fileprivate struct Bounds {
    typealias Bound = (lower: Float, upper: Float)
    let x: Bound = (-3, 3)
    let y: Bound = (-3, 3)
    let z: Bound = (-20, -8)
}

class Ball: SCNNode {
    private let bounds = Bounds()
    
    override init(){
        super.init()
        self.geometry = SCNSphere(radius: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var velocity : SCNVector3 = SCNVector3(x: 0.05, y: -0.075, z: 0.095)
    // TODO: Bounce, check position
    
    func updatePosition() {
        self.position = self.position + self.velocity
        
        if self.position.x < bounds.x.lower {
            self.position.x = bounds.x.lower
            self.velocity.x *= -1
        }
        if self.position.y < bounds.y.lower {
            self.position.y = bounds.y.lower
            self.velocity.y *= -1
        }
        if self.position.z < bounds.z.lower {
            self.position.z = bounds.z.lower
            self.velocity.z *= -1
        }
        
        if self.position.x > bounds.x.upper {
            self.position.x = bounds.x.upper
            self.velocity.x *= -1
        }
        if self.position.y > bounds.y.upper {
            self.position.y = bounds.y.upper
            self.velocity.y *= -1
        }
        if self.position.z > bounds.z.upper {
            self.position.z = bounds.z.upper
            self.velocity.z *= -1
        }
    }
}
