//
//  ARSceneViewController+Scene.swift
//  AR-Build-Your-Game
//
//  Created by Eduardo Quintero on 6/25/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

extension ARSceneViewController {
    
    func addSceneMap(positionNode: SCNNode ) -> SCNScene {
        
        let boundingBox = positionNode.boundingBox.max
         
        let sceneMap = boundingBox.x < boundingBox.y ? SCNScene(named: "art.scnassets/Demo.scn")! : SCNScene(named: "art.scnassets/MapGrid.scn")!
        
        let plane = sceneMap.rootNode.childNode(withName: "plane", recursively: true)
        
        plane?.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1 ) //(largeSize  )
            
        plane?.orientation = positionNode.worldOrientation
            
            
        plane?.position = positionNode.worldPosition
            
        return sceneMap
        
  
    }
    
    
    
    
    
    
    
    
    
    
}
