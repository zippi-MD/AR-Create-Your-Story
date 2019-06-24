//
//  Player.swift
//  AR-Build-Your-Game
//
//  Created by Carlos Daniel Hernandez Chauteco on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import SceneKit

class Character: SCNNode {
    var isJump: Bool?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
