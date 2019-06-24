//
//  Player.swift
//  AR-Build-Your-Game
//
//  Created by Carlos Daniel Hernandez Chauteco on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import SceneKit

class Character: SCNNode {
    var isJumping: Bool = false {
        didSet {
            
        }
    }
    
    override init() {
        super.init()
        loadModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadModel() {
        guard let scenePath = Bundle.main.path(forResource: "max", ofType: "scn", inDirectory: "art.scnassets/character") else { return }
        let sceneUrl = URL(fileURLWithPath: scenePath)
        guard let scene = try? SCNScene(url: sceneUrl, options: nil) else { return }
        guard let maxNode = scene.rootNode.childNode(withName: "Max_rootNode", recursively: true), let collitionNode = maxNode.childNode(withName: "collider", recursively: true) else { return }
        self.name = "Character"
        self.addChildNode(maxNode)
        
        collitionNode.physicsBody?.collisionBitMask = Int(([.enemy] as Bitmask).rawValue)
        
        let (minBound, maxBound) = maxNode.boundingBox
        let collitionCapsuleRadius = CGFloat(maxBound.x - minBound.x) * CGFloat(0.4)
        let collitionCapsuleHeight = CGFloat(maxBound.y - minBound.y)
        
        let collitionGeometry = SCNCapsule(capRadius: collitionCapsuleRadius, height: collitionCapsuleHeight)
        let physicsShape = SCNPhysicsShape(geometry: collitionGeometry, options: [.collisionMargin: CGFloat(0.04)])
        
    }
}
