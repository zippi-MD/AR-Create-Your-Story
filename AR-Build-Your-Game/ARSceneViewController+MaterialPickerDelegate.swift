//
//  ARSceneViewController+MaterialPickerDelegate.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/27/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import Foundation

extension ARSceneViewController: MaterialPickerDelegate {
    func pickerDidChangeValueTo(_ material: Material) {
        typeOfFloorSelected = material.floor
    }
    
    
}
