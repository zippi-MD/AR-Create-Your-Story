//
//  ARSceneViewController+Touches.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/27/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import UIKit
import SceneKit

extension ARSceneViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        guard let state = actualState else { return }
        
        switch state {
        case .selectingPlane:
            return
        case .placingGamePlane:
            return
        case .buildingMap:
            guard let touch = touches.first else { return }
            
            let location = touch.location(in: sceneView)
            
            guard let hit = sceneView.hitTest(location, options: nil).first else {
                //TO Do - send alert to the user telling him to touch the scene
                return
            }
            let selectedNode = hit.node
            if let name = selectedNode.name, name != "plane"{
//                To do  - handle selected node
                guard let floor = typeOfFloorSelected else { return }
                
                if let placedNode = blocksOnScene[name]{
                    
                    if floor == .none {
                        placedNode.0.removeFromParentNode()
                        blocksOnScene.removeValue(forKey: name)
                        
                        if placedNode.1 == .player {
                            playerLocation = nil
                        }
                        
                    }
                    
                    if placedNode.1 == floor {
                        return
                    }
                    else if floor == .player {
                        return
                    }
                    else {
                        placedNode.0.removeFromParentNode()
                        
                        if placedNode.1 == .player {
                            playerLocation = nil
                        }
                        
                    }
                }
                
                if floor == .none {
                    return
                }
                
                if let _ = playerLocation, floor == .player {
                    return
                }
                
                
                
                let newBlock = addBlock(scene: sceneView.scene, node: selectedNode, type: floor)
                newBlock.childNodes[0].name = name
                
                
                sceneView.scene.rootNode.addChildNode(newBlock)
                
                SCNTransaction.animationDuration = 0.25
                
                let tempScale = newBlock.scale
                
                newBlock.scale = SCNVector3(x: 0.25, y: 0.25, z: 0.25)
                //newBlock.scale = tempScale
                SCNTransaction.commit()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
               
                SCNTransaction.animationDuration = 0.25
                
                
                newBlock.scale = tempScale
                SCNTransaction.commit()
                }
                
                
                blocksOnScene[name] = (newBlock,floor)
                
                if floor == .player {
                    playerLocation = (name, newBlock)
                }
                
                
                
            }
            
        }
        
    }
}
