//
//  Material.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import UIKit


struct Material {
    let name: String
    let image: UIImage
    let floor: FloorType
}


let grass = Material(name: "Pasto", image: UIImage(named: "grass")!, floor: .grass)
let water = Material(name: "Agua", image: UIImage(named: "water")!, floor: .water)
let fire = Material(name: "Lava", image: UIImage(named: "fire")!, floor: .fire)
let ice = Material(name: "Hielo", image: UIImage(named: "ice")!, floor: .ice)
let none = Material(name: "Nada", image: UIImage(named: "none")!, floor: .none)

let materials = [grass, water, fire, ice, none]
