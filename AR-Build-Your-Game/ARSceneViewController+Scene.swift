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
         
        
        
        var largeSize = higherBounding(positionNode.boundingBox.max)

       
        
        
        if (positionNode.boundingBox.max.x < positionNode.boundingBox.max.y){
            var sceneMap = SCNScene(named: "art.scnassets/Demo.scn")
            
            var plane = sceneMap?.rootNode.childNode(withName: "plane", recursively: true)
            plane?.scale = SCNVector3(x: (1) * largeSize, y: (1) * largeSize, z: 1 * largeSize ) //(largeSize  )
            
            plane?.orientation = positionNode.worldOrientation
            
            
            plane?.position = positionNode.worldPosition
            
            return sceneMap!
            
        
        
        }else{
            
            var sceneMap = SCNScene(named: "art.scnassets/MapGrid.scn")
            
            var plane = sceneMap?.rootNode.childNode(withName: "plane", recursively: true)
            plane?.scale = SCNVector3(x: (1) * largeSize, y: (1) * largeSize, z: (1) * largeSize)
            
            plane?.orientation = positionNode.worldOrientation
            
            
            plane?.position = positionNode.worldPosition
            
             return sceneMap!
        }
        
        
        
        
        
    
        
    }
    
}
