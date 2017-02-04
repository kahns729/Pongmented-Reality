//
//  Ball.swift
//  Pongmented Reality
//
//  Created by Seth Kahn on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import SceneKit

class Ball: SCNNode {
    override init(){
        super.init()
        self.geometry = SCNSphere(radius: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var velocity : SCNVector3 = SCNVector3(x: 0.0, y: 0.0, z: 0.1)
    // TODO: Bounce, check position
    
    func updatePosition() {
        self.position = self.position + self.velocity
    }
}
