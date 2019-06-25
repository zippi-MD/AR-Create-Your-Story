//
//  BoundingFunction.swift
//  AR-Build-Your-Game
//
//  Created by Eduardo Quintero on 6/25/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//


import ARKit
import  SceneKit

func higherBounding(_ bounds: SCNVector3) -> Float {
    var higher : Float = 0
    if(bounds.x < bounds.z){
        
        higher = bounds.z
        
    }else{
        higher = bounds.x
    }
    return higher
    
}
