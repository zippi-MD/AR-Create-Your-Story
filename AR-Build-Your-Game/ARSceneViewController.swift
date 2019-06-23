//
//  ARSceneViewController.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/23/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import UIKit
import ARKit

class ARSceneViewController: UIViewController {
    
    var sceneView: ARSCNView!
    var debugPlanes = [SCNNode]()
    
    override func loadView() {
        super.loadView()
        
        sceneView = ARSCNView(frame: view.bounds)
        
        view.addSubview(sceneView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupARConfiguration()
    }
    
    func setupARConfiguration(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.delegate = self
        
        #if DEBUG
        
        sceneView.debugOptions = [.showFeaturePoints]
        
        #endif
    }

}
