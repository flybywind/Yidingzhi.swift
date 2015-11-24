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
import SpriteKit

class GameViewController: UIViewController {

    // MARK: properties
    var rotate3D: Rotate3D = Rotate3D(rx: 0, ry: 0, rz: 0,
        maxRx: Float(0.15*M_PI), maxRy: 0, maxRz: 0)
    var geometryNode: SCNNode!
    var cameraNode : SCNNode!
    var textureMaterial : SCNMaterialProperty?
    override func viewDidLoad() {
        super.viewDidLoad()
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/Nico_Robin.scn")!
        
        // create and add a camera to the scene
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.automaticallyAdjustsZRange = true;
        scene.rootNode.addChildNode(cameraNode)
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 600)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.light!.color = UIColor.whiteColor()
        lightNode.position = SCNVector3(x: 0, y: 800, z: 250)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.whiteColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        geometryNode = scene.rootNode.childNodeWithName("Nico_Robin", recursively: true)!
        
        // set texture
        setTextureOn("Abbigliamento",
            texture2D: self.getTexture("grid"))
        setTextureOn("Gambe",
            texture2D: self.getTexture("baowen"))
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
//        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
//        scnView.backgroundColor = UIColor.grayColor()
        
        // add a tap gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        scnView.addGestureRecognizer(panGesture)
        scnView.addGestureRecognizer(pinchGesture)
//        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
//        scnView.addGestureRecognizer(tapGesture)
    }
    
    func setTextureOn(destPart:String, texture2D texture:SKTexture) {
        let part = geometryNode.childNodeWithName(destPart, recursively: true)!
        part.geometry!.firstMaterial!.diffuse.contents = texture
        part.geometry!.firstMaterial!.diffuse.wrapT = .Repeat
        part.geometry!.firstMaterial!.diffuse.wrapS = .Repeat
        
    }
    
    func getTexture(textName:String) ->SKTexture {
        let texture2D = SKTexture.init(imageNamed: textName)
        texture2D.filteringMode = .Nearest
        
        return texture2D
    }
    func handleTap(gestureRecognize: UITapGestureRecognizer){
        let position = gestureRecognize.locationInView(self.view)
        print("old location:", geometryNode.position)
        geometryNode.position =
            SCNVector3Make(Float(position.x/10),
                Float(position.y/10), geometryNode.position.z)
        print("new location:", geometryNode.position, "\n================")
        
    }
    func handlePinch(gestureRecognize: UIPinchGestureRecognizer) {
        let scale = Float(gestureRecognize.scale)
        var depth = cameraNode.position.z
        depth += (50*(scale-1))
        cameraNode.position.z = depth
    }
    func handlePan(gestureRecognize: UIPanGestureRecognizer) {
        let pan = gestureRecognize.translationInView(self.view)
        let ry = (Float)(pan.x/10) * (Float)(M_PI/180.0)
        let rx = (Float)(pan.y/50) * (Float)(M_PI/180.0)
        rotate3D.rotate3DAdd(rotX: rx, rotY: ry, rotZ: 0)
        let rotMat = rotate3D.rotate3DMatrix()
        geometryNode.transform = SCNMatrix4Translate(rotMat,
            geometryNode.position.x, geometryNode.position.y,
            geometryNode.position.z)
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
