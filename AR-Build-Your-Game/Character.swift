//
//  Player.swift
//  AR-Build-Your-Game
//
//  Created by Carlos Daniel Hernandez Chauteco on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import SceneKit

class Character: SCNNode {
    //Mark variables
    private var sounds = [CharacterSounds: SCNAudioSource]()
    private var animations = [CharacterAnimations: SCNAnimationPlayer]()
    private var stepSounds = [SCNAudioSource](repeating: SCNAudioSource(), count: 10)
    private var particles = [CharacterParticles: (particle: SCNParticleSystem,birthRate: CGFloat)]()
    //
    var isJumping: Bool = false {
        didSet {
            
        }
    }
    
    var isWalking: Bool = false {
        didSet {
            if oldValue != isWalking {
                if isWalking {
                    
                }else{
                    
                }
            }
        }
    }
    override init() {
        super.init()
        loadModel()
        loadParticles()
        loadSounds()
        loadAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //load functions
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
        guard let jumpParticleScene = SCNScene(named: "art.scnassets/character/jump_dust.scn"), let burnParticleScene = SCNScene(named: "art.scnassets/particles/burn.scn"), let spinParticleScene = SCNScene(named: "art.scnassets/particles/particles_spin.scn"), let maxNode = self.childNode(withName: "Max_rootNode", recursively: true) else { return }
        
        particles[.jumpDust] = loadParticle(named: "particle", inSCene: jumpParticleScene)
        
        let particleEmitter = SCNNode()
        maxNode.addChildNode(particleEmitter)
        let scenePrincipal = SCNScene()
        scenePrincipal.rootNode.addChildNode(maxNode.clone())

        particles[.fireEmitter] = loadParticle(named: "fire", inSCene: burnParticleScene)

        particles[.smokeEmitter] = loadParticle(named: "smoke", inSCene: burnParticleScene)

        particles[.whiteSmokeEmitter] = loadParticle(named: "whiteSmoke", inSCene: burnParticleScene)

        particles[.spinParticle] = loadParticle(named: "particles_spin", inSCene: spinParticleScene)

        particles[.spinCircleParticle] = loadParticle(named: "particles_spin_circle", inSCene: spinParticleScene)

        particleEmitter.position = SCNVector3Make(0, 0.05, 0)
        particleEmitter.addParticleSystem(particles[.fireEmitter]?.particle ?? SCNParticleSystem())
        particleEmitter.addParticleSystem(particles[.smokeEmitter]?.particle ?? SCNParticleSystem())
        particleEmitter.addParticleSystem(particles[.whiteSmokeEmitter]?.particle ?? SCNParticleSystem())

        particles[.attachParticleAttach] = loadParticle(named: "particles_spin_circle", inSCene: scenePrincipal)
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
        
        sounds[.stepSound] = loadSound(named: "Step_rock", fileExtention: "mp3", volume: 0.5)
    }
    
    private func loadAnimations() {
        guard let maxNode = self.childNode(withName: "Max_rootNode", recursively: true) else { return }
        loadAnimation(fromScene: "art.scnassets/character/max_idle.scn") {[unowned self] (animaton) in
            self.addAnimation(animation: animaton, whitKey: .idle, toNode: maxNode)
            animaton.play()
        }
        
        loadAnimation(fromScene: "art.scnassets/character/max_walk.scn") {[unowned self] (animation) in
            animation.speed = 2.0
            animation.stop()
            
            animation.animation.animationEvents = [
                SCNAnimationEvent(keyTime: 0.1, block: {[unowned self] (_,_,_) in self.playSound(soundType: .stepSound) }),
                SCNAnimationEvent(keyTime: 0.6, block: {[unowned self] (_,_,_) in self.playSound(soundType: .stepSound) })
            ]
            
            self.addAnimation(animation: animation, whitKey: .walk, toNode: maxNode)
        }
        
        loadAnimation(fromScene: "art.scnassets/character/max_jump.scn") {[unowned self] (animation) in
            animation.animation.isRemovedOnCompletion = false
            animation.stop()
            
            animation.animation.animationEvents = [ SCNAnimationEvent(keyTime: 0, block: { [unowned self] (_,_,_) in self.playSound(soundType: .jumpSound)})]
            
            self.addAnimation(animation: animation, whitKey: .jump, toNode: maxNode)
        }
        
        loadAnimation(fromScene: "art.scnassets/character/max_spin.scn") {[unowned self] (animation) in
            animation.animation.isRemovedOnCompletion = false
            animation.speed = 1.5
            animation.stop()
            
            animation.animation.animationEvents = [ SCNAnimationEvent(keyTime: 0, block: {[unowned self] (_,_,_) in self.playSound(soundType: .attackSound)})]
            
            self.addAnimation(animation: animation, whitKey: .spin, toNode: maxNode)
        }
    }
    //Utils
    private func loadSound(named: String, fileExtention: String,volume: Float) -> SCNAudioSource?{
        guard let sound = SCNAudioSource(named: "audio/\(named).\(fileExtention)") else { return nil }
        sound.volume = volume
        sound.isPositional = false
        sound.load()
        
        return sound
    }
    
    private func loadParticle(named name: String, inSCene scene : SCNScene) -> (SCNParticleSystem, CGFloat)?{
        guard let particleNode = scene.rootNode.childNode(withName: name, recursively: true), let particle = particleNode.particleSystems?.first else { return nil }
        let returnValue = (particle,particle.birthRate)
        particle.birthRate = 0
        return returnValue
    }
    
    private func playSound(soundType: CharacterSounds){
        guard let sound = sounds[soundType], let maxNode = self.childNode(withName: "Max_rootNode", recursively: true) else { return }
        maxNode.runAction(SCNAction.playAudio(sound, waitForCompletion: false))
    }
    
    private func loadAnimation(fromScene directory: String, configAnimation: (_ animation: SCNAnimationPlayer)->Void ) {
        guard let animationScene = SCNScene(named: directory) else { return }
        
        var animationPlayer = SCNAnimationPlayer()
        
        animationScene.rootNode.enumerateChildNodes { (child, stop) in
            if !child.animationKeys.isEmpty {
                guard let firstAnimationKey = child.animationKeys.first,let animation = child.animationPlayer(forKey: firstAnimationKey) else { return }
                animationPlayer = animation
                stop.pointee = true
            }
        }
        
        configAnimation(animationPlayer)
    }
    
    private func addAnimation(animation: SCNAnimationPlayer, whitKey key: CharacterAnimations, toNode node: SCNNode) {
        node.addAnimationPlayer(animation, forKey: key.rawValue)
    }
}
