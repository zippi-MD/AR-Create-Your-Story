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
    case buildingMap
}

enum FloorType: String, CaseIterable{
    case grass = "grass"
    case water = "water"
    case fire  = "fire"
    case enemy = "enemy"
    case ice   = "ice"
    case none = "none"
    case player = "panda"
    
}

enum CharacterSounds {
    case ahhSound
    case catchFireSound
    case ouchSound
    case hitSound
    case hitEnemySound
    case explodeEnemySound
    case jumpSound
    case attackSound
    case stepSound
}

enum CharacterParticles {
    case jumpDust
    case fireEmitter
    case smokeEmitter
    case whiteSmokeEmitter
    case spinParticle
    case spinCircleParticle
    case attachParticleAttach
}

enum CharacterAnimations: String {
    case idle = "idle"
    case walk = "walk"
    case jump = "jump"
    case spin = "spin"
}
