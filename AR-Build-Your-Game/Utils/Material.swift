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
}


let grass = Material(name: "Pasto", image: UIImage(named: "grass")!)
let water = Material(name: "Agua", image: UIImage(named: "water")!)
let fire = Material(name: "Lava", image: UIImage(named: "fire")!)

let materials = [grass, water, fire]
