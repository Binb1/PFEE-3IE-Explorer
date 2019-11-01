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
    
    init(width: CGFloat = 10, height: CGFloat = 10, content: Any, doubleSided: Bool, horizontal: Bool) {
        
        super.init()
        
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
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("Plane Node Coder Not Implemented") }
    
}
