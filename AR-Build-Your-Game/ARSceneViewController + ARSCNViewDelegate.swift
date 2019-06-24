//
//  ARSceneViewController + ARSCNViewDelegate.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/23/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import Foundation
import ARKit

extension ARSceneViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            let plane = createPlane(center: planeAnchor.center, extent: planeAnchor.extent)
            debugPlanes.append(plane)
            DispatchQueue.main.async {
                node.addChildNode(plane)
            }
            
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        if node.childNodes.count > 0 {
            updatePlane(node.childNodes[0], center: planeAnchor.center, extent: planeAnchor.extent)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let state = actualState else { return }
        switch state {
        case .selectingPlane:
            DispatchQueue.main.async {
                
                let crosshairColor: UIColor
                
                if let _ = self.sceneView.hitTest(self.viewCenter, types: [.existingPlaneUsingExtent]).first {
                    crosshairColor = .green
                }
                else {
                    crosshairColor = .gray
                }
                
                self.crosshair.backgroundColor = crosshairColor
                
            }
            
        }
    }
}
