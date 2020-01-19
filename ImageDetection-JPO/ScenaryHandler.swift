//
//  ScenaryHandler.swift
//  ImageDetection-JPO
//
//  Created by Robin Champsaur on 05/07/2018.
//  Copyright © 2018 Robin Champsaur. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class ScenaryHandler {
    
    let nodeHandler = NodeHandler()
    var iOSNodes : [SCNNode]
    var androidNodes: [SCNNode]
    var webNodes : [SCNNode]
    var arNodes : [SCNNode]
    var designNodes : [SCNNode]
    
    init () {
        iOSNodes = []
        androidNodes = []
        webNodes = []
        arNodes = []
        designNodes = []
    }
    
    func addObjectsToiOSSection(planeSurface: SCNNode) {
        let vect = SCNVector3(1, 0, 0)
        nodeHandler.createSCObjectWithVectorOnSurface(name: "objects.scnassets/XWing.scn", rootname: "XWing", vect: vect, planeSurface: planeSurface)
    }
    
    func runiOSScenary(sceneView: ARSCNView, iosCalled: Bool) {
        if (!iosCalled) {
            let vect = SCNVector3(-2, 0.5, -6)
            let node = nodeHandler.createAndReturnSCObjectWithVector(name: "objects.scnassets/mobile-phone.scn", rootname: "mobile-phone", sceneView: sceneView, vect: vect)
            let textImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "iosText", position: SCNVector3(0, 1, -3), width: 1.5, height: 1)
            iOSNodes.append(textImage)
            
            let textNode = addLabelToSection(section: "Projets: 27", node: sceneView.scene.rootNode, position: SCNVector3(-2, 1.5, -1.5))
            iOSNodes.append(textNode)
            
            let studentImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "ios3IE", leftOrientation: true)
            iOSNodes.append(studentImage)
            
            if let node = node {
                iOSNodes.append(node)
            }
        }
    }
    
    func runAndroidScenary(sceneView: ARSCNView, androidCalled: Bool) {
        if (!androidCalled) {
            print("android section")
            let vect = SCNVector3(1, 0, -1.5)
            let node = nodeHandler.createAndReturnSCObjectWithVector(name: "objects.scnassets/Andy.scn", rootname: "Andy", sceneView: sceneView, vect: vect)
            
            let textImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "androidText", position: SCNVector3(0, 1, -3), width: 1.5, height: 1)
            androidNodes.append(textImage)
            
            let textNode = addLabelToSection(section: "Projets: 24", node: sceneView.scene.rootNode, position: SCNVector3(2, 1.5, -1.5))
            androidNodes.append(textNode)
            
            let studentImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "android3IE", leftOrientation: false)
            androidNodes.append(studentImage)
            
            if let node = node {
                androidNodes.append(node)
            }
        }
    }
    
    func runWebScenary(sceneView: ARSCNView, webCalled: Bool) {
        if (!webCalled) {
            let vect = SCNVector3(1, 0, 1)
            let node = nodeHandler.createAndReturnSCObjectWithVector(name: "objects.scnassets/Coliseum.scn", rootname: "Coliseum", sceneView: sceneView, vect: vect)
            if let node = node {
                webNodes.append(node)
            }
            
            let textImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "webText", position: SCNVector3(0, 1, -3), width: 1.5, height: 1)
            webNodes.append(textImage)
            
            let textNode = addLabelToSection(section: "Projets: 35", node: sceneView.scene.rootNode, position: SCNVector3(2, 1.5, -1.5))
            webNodes.append(textNode)
            
            let studentImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "web3IE", leftOrientation: false)
            webNodes.append(studentImage)
        }
    }
    
    func runARScenary(sceneView: ARSCNView, arCalled: Bool) {
        if (!arCalled) {
            
            let vect = SCNVector3(-5, 0.5, -2)
            let node = nodeHandler.createAndReturnSCObjectWithVector(name: "objects.scnassets/XWing.scn", rootname: "XWing", sceneView: sceneView, vect: vect)
            if let node = node {
                arNodes.append(node)
            }
            
            let textImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "arText", position: SCNVector3(0, 1, -3), width: 1.5, height: 1)
            arNodes.append(textImage)
            
            let textNode = addLabelToSection(section: "Projets: 12", node: sceneView.scene.rootNode, position: SCNVector3(-2, 1.5, -1.5))
            arNodes.append(textNode)
            
            let studentImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "ar3IE", leftOrientation: true)
            arNodes.append(studentImage)
        }
    }
    
    func runDesignScenary(sceneView: ARSCNView, designCalled: Bool) {
        if (!designCalled) {
            let textImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "desginText", position: SCNVector3(0, 1, -3), width: 1.5, height: 1)
            designNodes.append(textImage)
            
            let textNode = addLabelToSection(section: "Créations: 70", node: sceneView.scene.rootNode, position: SCNVector3(2, 1.5, -1.5))
            designNodes.append(textNode)
            
            let studentImage = nodeHandler.createSCNodeImage(sceneView: sceneView, imageName: "ar3IE", leftOrientation: true)
            designNodes.append(studentImage)
        }
    }

    
    func cancelScenaris(iosCalled: Bool, androidCalled: Bool, webCalled: Bool, arCalled: Bool, designCalled: Bool, sceneView: ARSCNView) {
        if (!iosCalled) {
            for node in iOSNodes {
                sceneView.scene.rootNode.childNode(withName: node.name!, recursively: true)?.removeFromParentNode()
            }
        }
        if (!androidCalled) {
            for node in androidNodes {
                sceneView.scene.rootNode.childNode(withName: node.name!, recursively: true)?.removeFromParentNode()
            }
        }
        if (!webCalled) {
            for node in webNodes {
                sceneView.scene.rootNode.childNode(withName: node.name!, recursively: true)?.removeFromParentNode()
            }
        }
        if (!arCalled) {
            for node in arNodes {
                sceneView.scene.rootNode.childNode(withName: node.name!, recursively: true)?.removeFromParentNode()
            }
        }
        if (!designCalled) {
            for node in designNodes {
                sceneView.scene.rootNode.childNode(withName: node.name!, recursively: true)?.removeFromParentNode()
            }
        }
    }
    
    func runScenary3IE(objectName: String, sceneView: ARSCNView, ref: ARReferenceImage, node: SCNNode) {
        if objectName.lowercased().range(of:"under") != nil {
            let vect = SCNVector3(0, 0, 4.5)
            nodeHandler.createSCObjectWithVector(name: "objects.scnassets/Creeper.scn", rootname: "Creeper", sceneView: sceneView, vect: vect)
        } else if objectName.lowercased().range(of:"le lab 3ie") != nil {
            let vect = SCNVector3(1, 0, -5.5)
            nodeHandler.createSCObjectWithVector(name: "objects.scnassets/XWing.scn", rootname: "XWing", sceneView: sceneView, vect: vect)
            addSKScene(dicoDescr: objectName, ref: ref, node: node)
        } else if objectName.lowercased().range(of:"pôle design") != nil {
            let vect = SCNVector3(1, 0, -5.5)
            nodeHandler.createSCObjectWithVector(name: "objects.scnassets/FloatingIsland.scn", rootname: "FloatingIsland", sceneView: sceneView, vect: vect)
            addSKScene(dicoDescr: objectName, ref: ref, node: node)
        } else {
            addSKScene(dicoDescr: objectName, ref: ref, node: node)
        }
    }
    
    func addLabelToSection(section: String, node: SCNNode, position: SCNVector3) -> SCNNode {
        let skScene = self.nodeHandler.createSceneWithLabel(text: section)
        //Create a plane on top of the detected image
        let plane = SCNPlane(width: 2,
                             height: 2)
        let material = SCNMaterial()
        material.lightingModel = SCNMaterial.LightingModel.constant
        material.isDoubleSided = false
        material.diffuse.contents = skScene
        plane.materials = [material]
        let planeNode = SCNNode(geometry: plane)
        planeNode.opacity = 1
        
        if position.x < 0 {
            planeNode.eulerAngles.y = .pi/4
        } else {
            planeNode.eulerAngles.y = -.pi/4
        }
        
        planeNode.name = section
        planeNode.position = position
        
        node.addChildNode(planeNode)
        return planeNode
    }
    
    func addSKScene(dicoDescr: String, ref: ARReferenceImage, node: SCNNode) {
        //Creation of the SKScene, the SKLabelNode and the SCNPlane
        let skScene = self.createScene(dicoDescr: dicoDescr)
        
        //Create a plane on top of the detected image
        let plane = SCNPlane(width: ref.physicalSize.width,
                             height: ref.physicalSize.height)
        let material = SCNMaterial()
        material.lightingModel = SCNMaterial.LightingModel.constant
        material.isDoubleSided = false
        material.diffuse.contents = skScene
        plane.materials = [material]
        let planeNode = SCNNode(geometry: plane)
        planeNode.opacity = 1
        planeNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
    }
    
    // Function that will call the NodeHandler function to create the perfect scene
    // depending on the image recognised
    func createScene(dicoDescr: String) -> SKScene {
        if checkAddImage(dicoDescr: dicoDescr) {
            return self.nodeHandler.createSceneWithNodeAndLabel(text: dicoDescr, imageName: "logo-epita.png")
        }
        return self.nodeHandler.createSceneWithLabel(text: dicoDescr)
    }
    
    // Function that will determine if an image need to be added under a label in the scene
    func checkAddImage(dicoDescr: String) -> Bool {
        if dicoDescr.lowercased().range(of: "Amphi 4") != nil ||
           dicoDescr.lowercased().range(of: "🇫🇷") != nil{
            return true
        }
        return false
    }
    
}
