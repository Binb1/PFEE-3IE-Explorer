//
//  ViewController.swift
//  ImageDetection-JPO
//
//  Created by Robin Champsaur on 25/06/2018.
//  Copyright © 2018 Robin Champsaur. All rights reserved.
//

//TODO - Fix the zposition of the plane on very big images

import UIKit
import SceneKit
import ARKit
import SpriteKit

class ViewController: UIViewController, ARSCNViewDelegate {
    

    @IBOutlet var gameView: GameView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    let scenaryHandler = ScenaryHandler()
    let imgDictionnary = ImageDictionnary()
    
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    var neatsie: Neatsie?
    
    var touch: UITouch?
    var direction = float2(0, 0)
    
    var plane: SCNNode!
    
    var iosCalled = false
    var androidCalled = false
    var webCalled = false
    var arCalled = false
    
    let iosPosition : [Float] = [-5, 0.0, 0.0, 4.0]
    let androidPosition : [Float] = [0.001, 0.0, 5.0, 4.0]
    let webPosition : [Float] = [0.001, 4.0, 5.0, 8.0]
    let arPosition : [Float] = [-5.0, 4.0, 0.0, 8.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView.delegate = self
        gameView.showsStatistics = true
        
        gameView.scene = SCNScene()
        gameView.session.delegate = self
        
        plane = Plane(content: UIColor.cyan.withAlphaComponent(0), doubleSided: true, horizontal: true)

        neatsie = Neatsie()
        if let node = SCNScene.init(named: "objects.scnassets/ned.scn")?.rootNode {
            neatsie?.animateNeatsie(node: node)
            neatsie?.addChildNode(node)
        }
        
        addPlane(object: neatsie)
        
//        if let iosSection = plane.childNode(withName: "iosSection", recursively: true) {
//            //scenaryHandler.addObjectsToiOSSection(planeSurface: iosSection)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureTracking(ressourceFolder: Constants.ARReference.folderName)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        gameView.session.pause()
    }
    
    @IBAction func resetCube(_ sender: Any) {
        self.gameView.scene = SCNScene()
        neatsie?.removeFromParentNode()
        
         plane = Plane(content: UIColor.cyan.withAlphaComponent(0), doubleSided: true, horizontal: true)

        neatsie = Neatsie()
        if let node = SCNScene.init(named: "objects.scnassets/ned.scn")?.rootNode {
            neatsie?.animateNeatsie(node: node)
            neatsie?.addChildNode(node)
        }
               
        addPlane(object: neatsie)
    }
    
    func configureTracking(ressourceFolder: String) {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: ressourceFolder, bundle: nil) else {
            fatalError("Missing expected asset catalog resources")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        gameView.session.run(configuration, options: [])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func addPlane(object: SCNNode? = nil){
        plane.position = SCNVector3(0, 0, -0.5)
        
        if let object = object {
            plane.addChildNode(object)
        }
        
        self.gameView.scene.rootNode.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let ref = imageAnchor.referenceImage
        updateQueue.async {
            //Triple check to see if the SKScene and the node can be created
            if let name = ref.name {
                if let dicoDescr = self.imgDictionnary.dictionnary[name] {
                    if !self.scenaryHandler.nodeHandler.onScreenNodes.contains(dicoDescr) {
                        //self.scenaryHandler.runScenary3IE(objectName: dicoDescr, sceneView: self.gameView, ref: ref, node: node)
                    }
                }
            }
        }
    }
    
  
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let directionInV3 = float3(x: direction.x, y: -direction.y, z: 0)
        neatsie?.walkInDirection(directionInV3)
        direction = float2(0, 0)
        print("x: \(neatsie!.position.x) y: \(neatsie!.position.y) z: \(neatsie!.position.z)")
        
        
        //Object plane presence detection
        if let neatsie = neatsie {
            if (neatsie.position.x >= iosPosition[0] && neatsie.position.x <= iosPosition[2] &&
                neatsie.position.y >= iosPosition[1] && neatsie.position.y <= iosPosition[3] ) { // iOS Section
                    if let iosSection = plane.childNode(withName: "iosSection", recursively: true) {
                        scenaryHandler.runiOSScenary(sceneView: self.gameView, iosCalled: self.iosCalled)
                        iosCalled = true
                        androidCalled = false
                        webCalled = false
                        arCalled = false
                        for i in 0...plane.childNodes.count - 1 {
                            plane.childNodes[i].opacity = 0.0
                        }
                        scenaryHandler.cancelScenaris(iosCalled: self.iosCalled, androidCalled: self.androidCalled, webCalled: self.webCalled, arCalled: self.arCalled, sceneView: self.gameView)
                        neatsie.opacity = 1.0
                        iosSection.opacity = 1.0
                    }
            } else if (neatsie.position.x >= androidPosition[0] && neatsie.position.x <= androidPosition[2] &&
                       neatsie.position.y >= androidPosition[1] && neatsie.position.y <= androidPosition[3]) { //Android Section
                    if let androidSection = plane.childNode(withName: "androidSection", recursively: true) {
                        scenaryHandler.runAndroidScenary(sceneView: self.gameView, androidCalled: self.androidCalled)
                        iosCalled = false
                        androidCalled = true
                        webCalled = false
                        arCalled = false
                        for i in 0...plane.childNodes.count - 1 {
                            plane.childNodes[i].opacity = 0.0
                        }
                        scenaryHandler.cancelScenaris(iosCalled: self.iosCalled, androidCalled: self.androidCalled, webCalled: self.webCalled, arCalled: self.arCalled, sceneView: self.gameView)
                        androidSection.opacity = 1.0
                        neatsie.opacity = 1.0
                    }
            } else if (neatsie.position.x >= webPosition[0] && neatsie.position.x <= webPosition[2] &&
                       neatsie.position.y >= webPosition[1] && neatsie.position.y <= webPosition[3]) {
                if let webSection = plane.childNode(withName: "webSection", recursively: true) {
                    //scenaryHandler.runAndroidScenary(sceneView: self.gameView, androidCalled: self.androidCalled)
                    iosCalled = false
                    androidCalled = false
                    webCalled = true
                    arCalled = false
                    for i in 0...plane.childNodes.count - 1 {
                        plane.childNodes[i].opacity = 0.0
                    }
                    scenaryHandler.cancelScenaris(iosCalled: self.iosCalled, androidCalled: self.androidCalled, webCalled: self.webCalled, arCalled: self.arCalled, sceneView: self.gameView)
                    webSection.opacity = 1.0
                    neatsie.opacity = 1.0
                }
            } else if (neatsie.position.x >= arPosition[0] && neatsie.position.x <= arPosition[2] &&
                       neatsie.position.y >= arPosition[1] && neatsie.position.y <= arPosition[3]) {
                if let arSection = plane.childNode(withName: "arSection", recursively: true) {
                    //scenaryHandler.runAndroidScenary(sceneView: self.gameView, androidCalled: self.androidCalled)
                    iosCalled = false
                    androidCalled = false
                    webCalled = false
                    arCalled = true
                    for i in 0...plane.childNodes.count - 1 {
                        plane.childNodes[i].opacity = 0.0
                    }
                    scenaryHandler.cancelScenaris(iosCalled: self.iosCalled, androidCalled: self.androidCalled, webCalled: self.webCalled, arCalled: self.arCalled, sceneView: self.gameView)
                    arSection.opacity = 1.0
                    neatsie.opacity = 1.0
                }
            } else {
                for i in 0...plane.childNodes.count - 1 {
                    plane.childNodes[i].opacity = 0.0
                }
                iosCalled = false
                androidCalled = false
                webCalled = false
                arCalled = false
                scenaryHandler.cancelScenaris(iosCalled: self.iosCalled, androidCalled: self.androidCalled, webCalled: self.webCalled, arCalled: self.arCalled, sceneView: self.gameView)
                neatsie.opacity = 1.0
            }
        }
    }
}


extension ViewController {

    // store touch in global scope
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touch {

            // Check whether our touch is within the joystick
            let touchLocation = touch.location(in: self.view)
            if gameView.virtualDPad().contains(touchLocation) {

                let middleOfCircleX = gameView.virtualDPad().origin.x + 75
                let middleOfCircleY = gameView.virtualDPad().origin.y + 75

                let lengthOfX = Float(touchLocation.x - middleOfCircleX)
                let lengthOfY = Float(touchLocation.y - middleOfCircleY)

                direction = float2(x: lengthOfX, y: lengthOfY)
                direction = normalize(direction)

                let degree = atan2(direction.x, direction.y)
                neatsie!.directionAngle = degree
                //print("moving x: \(direction.x) y: \(direction.y)")
            }
        }
    }
}
