//
//  CollitionMask.swift
//  AR-Build-Your-Game
//
//  Created by Carlos Daniel Hernandez Chauteco on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import Foundation

struct Bitmask: OptionSet {
    let rawValue: Int
    static let character = Bitmask(rawValue: 1 << 0) // the main character
    static let collision = Bitmask(rawValue: 1 << 1) // the ground and walls
    static let enemy = Bitmask(rawValue: 1 << 2) // the enemies
    static let trigger = Bitmask(rawValue: 1 << 3) // the box that triggers camera changes and other actions
    static let collectable = Bitmask(rawValue: 1 << 4) // the collectables (gems and key)
}
