//
//  GameViewController.swift
//  Yidingzhi
//
//  Created by flybywind on 15/11/22.
//  Copyright (c) 2015年 flybywind. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    // MARK: properties
    var rotate3D: Rotate3D = Rotate3D(rx: 0, ry: 0, rz: 0)
    var geometryNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/Nico_Robin.dae")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 50)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.light!.color = UIColor.whiteColor()
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.whiteColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        geometryNode = scene.rootNode.childNodeWithName("Nico_Robin", recursively: true)!
        geometryNode.position = SCNVector3(x: -400, y:380, z: -20)
        geometryNode.scale = SCNVector3(0.1, 0.1, 0.1)
        // animate the 3d object
//        geometryNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1)))
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
//        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        
        // add a tap gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        scnView.addGestureRecognizer(panGesture)
//        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
//        scnView.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(gestureRecognize: UITapGestureRecognizer){
        let position = gestureRecognize.locationInView(self.view)
        print("old location:", geometryNode.position)
//        geometryNode.pivot =
//            SCNMatrix4MakeTranslation((Float)(position.x),
//                (Float)(position.y), geometryNode.position.z)
        geometryNode.position =
            SCNVector3Make(Float(position.x/10),
                Float(position.y/10), geometryNode.position.z)
        print("new location:", geometryNode.position, "\n================")
        
    }
    func handlePan(gestureRecognize: UIPanGestureRecognizer) {
        // retrieve the SCNView
//        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let pan = gestureRecognize.translationInView(self.view)
        print("gesture rotate position:",pan)
        let ry = (Float)(pan.x/5) * (Float)(M_PI/180.0)
//            rx = (Float)(p.y) * (Float)(M_PI/180.0)
        let rx:Float = 0
        
        rotate3D.rotate3DAdd(rotX: rx, rotY: ry, rotZ: 0)
        geometryNode.transform = rotate3D.rotate3DMatrix()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
