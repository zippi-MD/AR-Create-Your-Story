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
        
        guard let state = actualState else {return}
        
        switch state {
        case .selectingPlane:
            guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
            let plane = createPlane(center: planeAnchor.center, extent: planeAnchor.extent)
            debugPlanes.append(plane)
            DispatchQueue.main.async {
                node.addChildNode(plane)
            }
        case .placingGamePlane:
            let plane = createPlane(center: self.planeCenter!, extent: self.planeExtent!)
            DispatchQueue.main.async {
                self.selectedPlane = plane
                node.addChildNode(plane)
                self.sceneView.scene = self.addSceneMap(positionNode: self.selectedPlane!)
                
                for node in self.sceneView.scene.rootNode.childNodes {
                    guard let nodeName = node.name else {continue}
                    if nodeName == "plane"{
                        let nodesNumber: [String: Int] = ["A": 1, "B": 3, "C":5, "D": 7, "E": 9, "F": 11, "G": 13, "H": 15, "I": 17, "J": 19, "K": 21, "L": 23, "M": 25]
                        for letterNode in node.childNodes {
                            guard let startingNumber = nodesNumber[letterNode.name!] else {continue}
                            var x = startingNumber
                            var y = 1
                            
                            for square in letterNode.childNodes{
                                square.name = "\(x),\(y)"
                                y += 1
                                if y == 11 {
                                    x += 1
                                    y = 1
                                }
                            }
                            
                        }
                        
                    }
                }
                
                self.actualState = .buildingMap
            }
        case .buildingMap:
            return
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
                
                if let result = self.sceneView.hitTest(self.viewCenter, types: [.existingPlaneUsingExtent]).first {
                    crosshairColor = .green
                    self.worldTransform = result.worldTransform
                    let planeAnchor = result.anchor as! ARPlaneAnchor
                    self.planeCenter = planeAnchor.center
                    self.planeExtent = planeAnchor.extent
                    
                }
                else {
                    crosshairColor = .gray
                    self.worldTransform = nil
                }
                
                self.crosshair.backgroundColor = crosshairColor
                
            }
            
        case .placingGamePlane:
            return
        case .buildingMap:
            return
            
        }
    }
}
