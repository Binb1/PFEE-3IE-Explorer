//
//  Plane.swift
//  ImageDetection-JPO
//
//  Created by Robin Champsaur on 24/10/2019.
//  Copyright © 2019 Robin Champsaur. All rights reserved.
//

import Foundation
import ARKit

class Plane: SCNNode{
    
    let iosSection: SCNNode = SCNNode()
    let androidSection: SCNNode = SCNNode()
    let webSection: SCNNode = SCNNode()
    let arSection: SCNNode = SCNNode()
    
    init(width: CGFloat = 4, height: CGFloat = 4, content: Any, doubleSided: Bool, horizontal: Bool) {
        super.init()
        
        //Init base plane
        self.geometry = SCNPlane(width: width, height: height)
        let material = SCNMaterial()
        
        if let colour = content as? UIColor{
            material.diffuse.contents = colour
        } else if let image = content as? UIImage{
            material.diffuse.contents = image
        } else{
            material.diffuse.contents = UIColor.cyan
        }

        self.geometry?.firstMaterial = material
        if doubleSided {
            material.isDoubleSided = true
        }
        if horizontal {
            self.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        }
        
        initSections()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("Plane Node Coder Not Implemented") }
    
    func initSections(width: CGFloat = 1, height: CGFloat = 1){
        iosSection.geometry = SCNPlane(width: width, height: height)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue.withAlphaComponent(0.7)
        material.isDoubleSided = true
        iosSection.geometry?.firstMaterial = material
        iosSection.position = SCNVector3(x: 0, y: 0, z: 0)
        iosSection.name = "iosSection"
        
        androidSection.geometry = SCNPlane(width: width, height: height)
        material.diffuse.contents = UIColor.green.withAlphaComponent(0.7)
        material.isDoubleSided = true
        androidSection.geometry?.firstMaterial = material
        androidSection.position = SCNVector3(x: 1, y: 1, z: 0)
        androidSection.name = "androidSection"
        
        webSection.geometry = SCNPlane(width: width, height: height)
        material.diffuse.contents = UIColor.yellow.withAlphaComponent(0.7)
        material.isDoubleSided = true
        webSection.geometry?.firstMaterial = material
        
        arSection.geometry = SCNPlane(width: width, height: height)
        material.diffuse.contents = UIColor.red.withAlphaComponent(0.7)
        material.isDoubleSided = true
        arSection.geometry?.firstMaterial = material
        
        self.addChildNode(iosSection)
        self.addChildNode(androidSection)
        //self.addChildNode(webSection)
        //self.addChildNode(arSection)
    }
    
}
