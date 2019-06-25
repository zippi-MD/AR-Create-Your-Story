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
    
    var worldTransform: simd_float4x4? = nil {
        willSet {
            if let _ = newValue {
                actionButton.view.isHidden = false
            }
            else {
                actionButton.view.isHidden = true
            }
        }
    }
    
    var planeExtent: simd_float3?
    var planeCenter: simd_float3?
    
    
    var selectedPlane: SCNNode?
    
    //MARK: Action Buttons
    let actionButton: ActionButtonViewController = {
        let button = ActionButtonViewController(text: "Seleccionar Plano")
        return button
    }()
    
    //MARK: Game State
    var actualState: GameState! {
        willSet {
            switch newValue! {
            case .selectingPlane:
                setupSelectingPlaneUI()
            case .placingGamePlane:
                setupPlacingGamePlaneUI()
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
        
        view.addSubview(actionButton.view)
        actionButton.didMove(toParent: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionButtonWasSelected))
        actionButton.view.addGestureRecognizer(tap)
        
        actionButton.view.isHidden = true
        
    }
    
    func setupPlacingGamePlaneUI(){
        actionButton.view.isHidden = true
        crosshair.isHidden = true
        
    }
    
    
    @objc func actionButtonWasSelected(){
        guard let state = actualState else {return}
        switch state {
        case .selectingPlane:
            if let worldTransform = worldTransform {
                
                let configuration = ARWorldTrackingConfiguration()
                configuration.planeDetection = []
                sceneView.debugOptions = []
                sceneView.session.run(configuration)
                
                for plane in debugPlanes{
                    plane.removeFromParentNode()
                }
                debugPlanes = []
                actualState = .placingGamePlane
                sceneView.session.add(anchor: ARAnchor.init(transform: worldTransform))
            }
        case .placingGamePlane:
            return
        }
    }

}
