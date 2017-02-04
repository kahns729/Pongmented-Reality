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
    var ball: Ball!
    var userPaddle: UserPaddle!
    
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue.current!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Scenekit setup
        setupView()
        setupScene()
        setupCamera()
        
        // CoreMotion
        setupMotionManagement()
        
        // Scene setup
        self.ball = spawnBall()
        self.userPaddle = spawnUserPaddle()
    }

    func setupView() {
        self.sceneView = SCNView(frame: self.view.frame)
        sceneView.backgroundColor = .black
        self.view = sceneView
        
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = false
    }
    
    func setupScene() {
        self.scene = SCNScene()
        self.sceneView.scene = scene
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        cameraNode.camera = SCNCamera()
        self.scene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnUserPaddle() -> UserPaddle {
        let userPaddle = UserPaddle()
        self.scene.rootNode.addChildNode(userPaddle)
        userPaddle.position = self.cameraNode.position
        userPaddle.addChildNode(self.cameraNode)
        //cameraNode.position = SCNVector3(x: -1, y: 1, z: 5)
        //cameraNode.orientation = SCNVector4(0, 0, 1, 0.25)
        return userPaddle
    }

    func spawnBall() -> Ball {
        // STUB, but reminder of how this works
        let ball = Ball()
        self.scene.rootNode.addChildNode(ball)
        ball.position = SCNVector3(x: 0, y: 0, z: -10)
        return ball
    }
}

extension PRGameViewController {
    func setupMotionManagement() {
        // STUB
        
        self.motionManager.deviceMotionUpdateInterval = 0.01
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
        }
    }
    
    func handleDeviceMotionUpdate(deviceMotion: CMDeviceMotion) {
//        let phoneOrientation = deviceMotion.attitude.quaternion
//        self.cameraNode.orientation = phoneOrientation
        let accel = deviceMotion.userAcceleration
//        self.ball.updatePosition()
        self.userPaddle.accelerate(accel: SCNVector3(x: Float(accel.x), y: Float(accel.y), z: 0))
        self.userPaddle.updatePosition()
    }
}
