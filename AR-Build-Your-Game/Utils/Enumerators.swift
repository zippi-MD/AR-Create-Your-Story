//
//  Enumerators.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import Foundation

enum GameState {
    case selectingPlane
    case placingGamePlane
}

enum FloorType: String, CaseIterable{
    case grass = "grass"
    case water = "water"
    case fire  = "fire"
    case enemy = "enemy"
    case ice   = "ice"
    
}
