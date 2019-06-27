//
//  ARSceneViewController+Touches.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/27/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import UIKit

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
            }
            
        }
        
    }
}
