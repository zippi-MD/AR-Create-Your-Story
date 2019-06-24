//
//  Player.swift
//  AR-Build-Your-Game
//
//  Created by Carlos Daniel Hernandez Chauteco on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import SceneKit

enum CharacterSounds {
    case ahhSound
    case catchFireSound
    case ouchSound
    case hitSound
    case hitEnemySound
    case explodeEnemySound
    case jumpSound
    case attackSound
}

class Character: SCNNode {
    //Mark variables
    private var sounds = [CharacterSounds: SCNAudioSource]()
    //
    var isJumping: Bool = false {
        didSet {
            
        }
    }
    
    override init() {
        super.init()
        loadModel()
        loadParticles()
        loadSounds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadModel() {
        guard let scenePath = Bundle.main.path(forResource: "max", ofType: "scn", inDirectory: "art.scnassets/character") else { return }
        let sceneUrl = URL(fileURLWithPath: scenePath)
        guard let scene = try? SCNScene(url: sceneUrl, options: nil) else { return }
        guard let maxNode = scene.rootNode.childNode(withName: "Max_rootNode", recursively: true), let collitionNode = maxNode.childNode(withName: "collider", recursively: true) else { return }
        self.name = "Character"
        self.addChildNode(maxNode)
        
        collitionNode.physicsBody?.collisionBitMask = Int(([.enemy] as Bitmask).rawValue)
        
        let (minBound, maxBound) = maxNode.boundingBox
        let collitionCapsuleRadius = CGFloat(maxBound.x - minBound.x) * CGFloat(0.4)
        let collitionCapsuleHeight = CGFloat(maxBound.y - minBound.y)
        
        let collitionGeometry = SCNCapsule(capRadius: collitionCapsuleRadius, height: collitionCapsuleHeight)
        let physicsShape = SCNPhysicsShape(geometry: collitionGeometry, options: [.collisionMargin: CGFloat(0.04)])
        
        let physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        
        collitionNode.physicsBody = physicsBody
    }
    
    private func loadParticles() {
        
    }
    
    private func loadSounds() {
        sounds[.ahhSound] = loadSound(named: "aah_extinction", fileExtention: "mp3", volume: 1.0)
        
        sounds[.catchFireSound] = loadSound(named: "panda_catch_fire", fileExtention: "mp3", volume: 5.0)
        
        sounds[.ouchSound] = loadSound(named: "ouch_firehit", fileExtention: "mp3", volume: 2.0)
        
        sounds[.hitSound] = loadSound(named: "hit", fileExtention: "mp3", volume: 2.0)
        
        sounds[.hitEnemySound] = loadSound(named: "Explosion1", fileExtention: "m4a", volume: 2.0)
        
        sounds[.explodeEnemySound] = loadSound(named: "Explosion2", fileExtention: "m4a", volume: 2.0)
        
        sounds[.jumpSound] = loadSound(named: "jump", fileExtention: "m4a", volume: 0.2)
        
        sounds[.attackSound] = loadSound(named: "attack", fileExtention: "mp3", volume: 1.0)
    }
    
    //Utils
    
    private func loadSound(named: String, fileExtention: String,volume: Float) -> SCNAudioSource?{
        guard let sound = SCNAudioSource(named: "audio/\(named).\(fileExtention)") else { return nil}
        sound.volume = volume
        sound.isPositional = false
        sound.load()
        
        return sound
    }
    
    private func playSound(sound: CharacterSounds) {
        guard let aux = sounds[sound], let maxNode = self.childNode(withName: "Max_rootNode", recursively: true) else { return }
        maxNode.runAction(SCNAction.playAudio(aux, waitForCompletion: false))
    }
}
