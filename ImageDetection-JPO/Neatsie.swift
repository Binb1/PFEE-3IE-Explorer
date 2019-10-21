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
    
    override init() {
        super.init()
        
        // create player
        let playerGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        playerGeometry.firstMaterial?.diffuse.contents = UIColor.blue

        position = SCNVector3(x: 5, y: 0.5, z: 0)

        // give the looks
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
                    y: CGFloat(directionAngle),
                    z: 0.0,
                    duration: 0.1, usesShortestUnitArc: true
                )
                runAction(action)
            }
        }
    }

    let speed: Float = 0.3

    func walkInDirection(_ direction: float3) {
        let currentPosition = float3(position)
        position = SCNVector3(currentPosition + direction * speed)
    }
}
