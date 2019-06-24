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
    
    //MARK: Selecting Plane Variables
    var viewCenter: CGPoint {
        let viewBounds = view.bounds
        return CGPoint(x: viewBounds.width / 2.0, y: viewBounds.height / 2.0)
    }
    
    let crosshair: UIView = {
        let crosshairSize = 10
        let view = UIView(frame: CGRect(x: 0, y: 0, width: crosshairSize, height: crosshairSize))
        view.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    //MARK: Game State
    var actualState: GameState! {
        willSet {
            switch newValue! {
            case .selectingPlane:
                setupSelectingPlaneUI()
            }
        }
    }

    override func loadView() {
        super.loadView()
        sceneView = ARSCNView(frame: view.bounds)
        view.addSubview(sceneView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupARConfiguration()
        actualState = .selectingPlane
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
    
    func setupSelectingPlaneUI(){
        crosshair.center = viewCenter
        view.addSubview(crosshair)
    }

}
