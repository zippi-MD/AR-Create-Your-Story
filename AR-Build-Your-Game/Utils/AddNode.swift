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
    var tempBlock = block.clone()
    
    let material = SCNMaterial()
    material.diffuse.contents = UIImage.init(named: "\(type.rawValue)-1")
    
    tempBlock.geometry?.materials = [material]
    tempBlock.position = node.worldPosition
    let plane = scene.rootNode.childNode(withName: "plane", recursively: true)!
    let divisor = Float(20)
    tempBlock.scale = SCNVector3(plane.scale.x/divisor, plane.scale.y/divisor, plane.scale.z/divisor)
    tempBlock.orientation = plane.orientation
    

    return tempBlock
    
    
}
