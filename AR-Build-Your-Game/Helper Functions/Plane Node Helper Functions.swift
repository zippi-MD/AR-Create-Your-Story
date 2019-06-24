//
//  Plane Node Helper Functions.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/23/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import SceneKit

func createPlane(center: vector_float3, extent: vector_float3) -> SCNNode {
    let plane = SCNPlane(width: CGFloat(extent.x), height: CGFloat(extent.z))
    let planeMaterial = SCNMaterial()
    planeMaterial.diffuse.contents = UIColor.white.withAlphaComponent(0.3)
    plane.materials = [planeMaterial]
    
    let planeNode = SCNNode(geometry: plane)
    planeNode.position = SCNVector3Make(center.x, 0, center.z)
    planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
    
    return planeNode
}

func updatePlane(_ node: SCNNode, center: vector_float3, extent: vector_float3) {
    let geometry = node.geometry as? SCNPlane
    geometry?.width = CGFloat(extent.x)
    geometry?.height = CGFloat(extent.z)
    
    node.position = SCNVector3Make(center.x, 0, center.z)
}
