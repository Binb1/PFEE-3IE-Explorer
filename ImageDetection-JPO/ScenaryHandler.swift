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
    
    init () {
        
    }
    
    func addObjectsToiOSSection(planeSurface: SCNNode) {
        let vect = SCNVector3(1, 0, 0)
        nodeHandler.createSCObjectWithVectorOnSurface(name: "objects.scnassets/XWing.scn", rootname: "XWing", vect: vect, planeSurface: planeSurface)
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
