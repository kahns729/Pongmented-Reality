//
//  PRGameViewController.swift
//  Pongmented Reality
//
//  Created by Gabriel Terrell on 2/4/17.
//  Copyright © 2017 Savage Patch Kids. All rights reserved.
//

import UIKit
import CoreMotion
import SceneKit

class PRGameViewController: UIViewController {
    var sceneView: SCNView!
    var scene: SCNScene!
    var cameraNode: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Scenekit setup
        setupView()
        setupScene()
        setupCamera()
        
        // CoreMotion
        setupMotionManagement()
        
        // Scene setup
        spawnSomething()
    }

    func setupView() {
        self.sceneView = SCNView(frame: self.view.frame)
        sceneView.backgroundColor = .black
        self.view = sceneView
        
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = false
    }
    
    func setupScene() {
        self.scene = SCNScene()
        self.sceneView.scene = scene
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        self.scene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnSomething() {
        // STUB, but reminder of how this works
        let circle = SCNSphere(radius: 0.5)
        let circleNode = SCNNode(geometry: circle)
        self.scene.rootNode.addChildNode(circleNode)
        circleNode.position = SCNVector3(x: 11, y: 0, z: 0)
    }
}

extension PRGameViewController {
    func setupMotionManagement() {
        // STUB
        /*
        self.motionManager.deviceMotionUpdateInterval = 0.1
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.startDeviceMotionUpdates(to: self.motionQueue) { deviceMotion, error in
                if error == nil, let deviceMotion = deviceMotion {
                    self.handleDeviceMotionUpdate(deviceMotion: deviceMotion)
                } else {
                    print("error not nil or device motion is nil")
                    print(error as Any)
                }
            }
        } else {
            print("device not available")
        }*/
    }
    
    func handleDeviceMotionUpdate(deviceMotion: CMDeviceMotion) {
        let phoneOrientation = deviceMotion.attitude.quaternion
        // self.cameraNode.orientation = phoneOrientation
    }
}
