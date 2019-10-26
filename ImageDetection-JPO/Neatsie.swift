//
//  Neatsie.swift
//  ImageDetection-JPO
//
//  Created by Robin Champsaur on 21/10/2019.
//  Copyright © 2019 Robin Champsaur. All rights reserved.
//

import Foundation
import SceneKit

final class Neatsie: SCNNode {

    var scene : SCNScene?
    
    init(width: CGFloat = 0.2, height: CGFloat = 0.2) {
        super.init()
        
        // create player
        let playerGeometry = SCNBox(width: width, height: height, length: 0.2, chamferRadius: 0)
        playerGeometry.firstMaterial?.diffuse.contents = UIColor.red.withAlphaComponent(0.9)

        position = SCNVector3(x: 0, y: 0.5, z: 0)
        geometry = playerGeometry

        // define shape, here a box around the player
        let shape = SCNPhysicsShape(
            geometry: playerGeometry,
            // default is box, give it a physics shape near to its looking shape
            options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox]
        )

        // assign physics body based on geometry body (here: player)
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: shape)
        physicsBody?.angularVelocityFactor = SCNVector3Zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var directionAngle: SCNFloat = 0.0 {
        didSet {
            if directionAngle != oldValue {
                let action = SCNAction.rotateTo(
                    x: 0.0,
                    y: 0.0,
                    z: CGFloat(directionAngle),
                    duration: 0.1, usesShortestUnitArc: true
                )
                runAction(action)
            }
        }
    }

    let speed: Float = 0.02

    func walkInDirection(_ direction: float3) {
        let currentPosition = float3(position)
        position = SCNVector3(currentPosition + direction * speed)
    }
}
