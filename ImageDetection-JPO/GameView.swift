//
//  GameView.swift
//  ImageDetection-JPO
//
//  Created by Robin Champsaur on 21/10/2019.
//  Copyright © 2019 Robin Champsaur. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
import ARKit

final class GameView: ARSCNView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setup2DOverlay()
    }
  
    func setup2DOverlay() {
        let viewHeight = bounds.size.height
        let viewWidth = bounds.size.width
        let sceneSize = CGSize(width: viewWidth, height: viewHeight)
        let skScene = SKScene(size: sceneSize)
        skScene.scaleMode = .resizeFill
        
        let dpadShape = SKShapeNode(circleOfRadius: 75)
        dpadShape.strokeColor = .white
        dpadShape.lineWidth = 2.0
        dpadShape.position.x = dpadShape.frame.size.width / 2 + 10
        dpadShape.position.y = dpadShape.frame.size.height / 2 + 10
        skScene.addChild(dpadShape)
        skScene.isUserInteractionEnabled = false
        skScene.backgroundColor = UIColor.red
        
        overlaySKScene = skScene
    }
    
    func virtualDPad() -> CGRect {
        var vDPad = CGRect(x: 0, y: 0, width: 150, height: 150)
        vDPad.origin.y = bounds.size.height - vDPad.size.height - 10
        vDPad.origin.x = 10
        return vDPad
    }

}
