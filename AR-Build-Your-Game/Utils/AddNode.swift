//
//  AddNode.swift
//  AR-Build-Your-Game
//
//  Created by Eduardo Quintero on 6/27/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import SceneKit


func addBlock(scene: SCNScene, node: SCNNode, type : FloorType  ) -> SCNNode{
    guard let block = SCNScene(named: "art.scnassets/blockMap.scn")?.rootNode.childNodes[0] else {
        assert(true, "Can't find blockMap")
        return SCNNode()
    }
    let tempBlock = block.clone()
    
    let material = SCNMaterial()
    material.diffuse.contents = UIImage.init(named: "\(type.rawValue)-1")
    
   
    tempBlock.position = node.worldPosition
    let plane = scene.rootNode.childNode(withName: "plane", recursively: true)!
  
    tempBlock.scale = SCNVector3(plane.scale.x, plane.scale.y, plane.scale.z)
    tempBlock.orientation = plane.orientation
    

    tempBlock.childNodes[0].geometry?.materials = [material]

    return tempBlock
    
    
}
