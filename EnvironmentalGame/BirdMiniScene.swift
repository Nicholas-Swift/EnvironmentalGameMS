//
//  BirdMiniScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/10/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import AVFoundation

/*enum BirdMiniSceneState {
    case active, notActive
} */
class BirdMiniScene: SKScene, SKPhysicsContactDelegate {
    //Top will be electrical wirings
    
    var audioPlayer = AVAudioPlayer()
    var bird: SKSpriteNode!
    var birdState: Bool = true
    var sinceTouch : CFTimeInterval = 0
    var fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 100
    var scrollLayer: SKNode!
    var obstacleSource: SKNode!
    var obstacleLayer: SKNode!
    var spawnTimer: CFTimeInterval = 0
    var timeBar: SKSpriteNode!
    var birdMiniMainLabel: SKLabelNode!
    var birdMiniLabel: SKLabelNode!
    var time: CGFloat = 1.0 {
        didSet {
            //Limits Time Bar
            if time > 1.0 {
                time = 1.0
            }
            // Scale time bar
            timeBar.xScale = time
        }
    }
    var countChecker: Int = UserDefaults.standard.integer(forKey: "Countchecker")
    
    //Game management
    //var gameState: BirdMiniSceneState = .active
    
    let birdFlap = SKAction(named: "BirdFlap")!
    let birdHit = SKAction(named: "BirdHit")!
    
    override func didMove(to view: SKView) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hustle", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error in loading Start Scene Background music")
        }
        
        audioPlayer.play()
        
        // Setup your scene here
        bird = self.childNode(withName: "bird") as! SKSpriteNode
        scrollLayer = self.childNode(withName: "scrollLayer")
        /* Set reference to obstacle Source node */
        obstacleSource = self.childNode(withName: "obstacle")
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        birdMiniMainLabel = self.childNode(withName: "birdMiniMainLabel") as! SKLabelNode
        birdMiniLabel = self.childNode(withName: "birdMiniLabel") as! SKLabelNode
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = false
            
        print("BirdMiniScene \(countChecker) count checker")
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Called when a touch begins
        birdMiniMainLabel.isHidden = true
        birdMiniLabel.isHidden = true
        
        if birdState == false {return}
        
        bird.run(birdFlap)
        bird.physicsBody?.affectedByGravity = true
        bird.physicsBody?.isDynamic = true
        
        /* Reset velocity, helps improve response against cumulative falling velocity */
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        // Apply vertical impulse
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
        
        // Apply subtle rotation
        bird.physicsBody?.applyAngularImpulse(1)
        
        // Reset touch timer
        sinceTouch = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if birdState == false {return}
        
        time -= 0.0017
        
        if countChecker >= 6 && countChecker < 9 {
            time -= 0.001
        }
        
        if countChecker >= 9 {
            time -= 0.0005
        }
        
        if time <= 0.9 {
            bird.physicsBody?.affectedByGravity = true
            bird.physicsBody?.isDynamic = true
        }
        
    
        
        //Player ran out of time
        if time < 0 {
            // print(time)
            completeGame()
        }
        
        /* Skip game update if game no longer active */
        //if gameState != .active { return }
        
        // Grab current velocity
        let velocityY = bird.physicsBody?.velocity.dy ?? 0
        
        // Check and cap vertical velocity
        if velocityY > 400 {
            bird.physicsBody?.velocity.dy = 400
        }
        
        // Apply falling rotation
        if sinceTouch > 0.2 {
            let impulse = -20000 * fixedDelta
            bird.physicsBody?.applyAngularImpulse(CGFloat(impulse))
        }
        
        // Clamp rotation
        bird.zRotation.clamp(v1: CGFloat(-90).degreesToRadians(), CGFloat(30).degreesToRadians())
        bird.physicsBody?.angularVelocity.clamp(v1: -1, 3)
        
        // Update last touch timer
        sinceTouch += fixedDelta
        
        // Process world scrolling
        scrollWorld()
        
        /* Process obstacles */
        updateObstacles()
        
        spawnTimer += fixedDelta
        
    }
    func scrollWorld() {
        // Scroll World
        scrollLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        // Loop through scroll layer nodes
        for ground in scrollLayer.children as! [SKSpriteNode] {
            
            // Get ground node position, convert node position to scene space
            let groundPosition = scrollLayer.convert(ground.position, to: self)
            
            // Check if ground sprite has left the scene
            if groundPosition.x <= -ground.size.width / 2 {
                
                // Reposition ground sprite to the second starting position
                let newPosition = CGPoint(x: (self.size.width / 2) + ground.size.width, y: groundPosition.y)
                
                // Convert new node position back to scroll layer space
                ground.position = self.convert(newPosition, to: scrollLayer)
            }
        }
    }
    func updateObstacles() {
        /* Update Obstacles */
        
        obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in obstacleLayer.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition = obstacleLayer.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if obstaclePosition.x <= -26 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                obstacle.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        if spawnTimer >= 1.7 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle = obstacleSource.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 450, y: CGFloat.random(min: 55, max: 175))
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        if nodeA.name == "goal" || nodeB.name == "goal" {
            print("BirdMiniScene Surviving")
        }
        
        /*/* Ensure only called while game running */
        if gameState != .active { return }
        
        /* Change game state to game over */
        gameState = .gameOver */
            
        else {
        print("BirdMiniScene dead")
        
        // bird.run(birdHit)
            
        let birdFailedGame = SKAction.run({
                self.failedGame()
        })
            
        audioPlayer.stop()
        let birdMiniDeadSequence = SKAction.sequence([birdHit, birdFailedGame])
        bird.run(birdMiniDeadSequence)
        
            
        birdState = false
        //gameState = .notActive
            
        bird.physicsBody?.isDynamic = false
            
        /* Stop any new angular velocity being applied */
        bird.physicsBody?.allowsRotation = false
        
        /* Reset angular velocity */
        bird.physicsBody?.angularVelocity = 0
        
        //failedGame()
        /* DispatchQueue.main.asyncAfter(deadline: .now() + duration){
            self.failedGame()
            print("BirdMiniScene failedGame will be called")
            } */
        }

        // let birdWait = SKAction.wait(forDuration: 2.0)
        
        
    }
    func completeGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") + 50, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        print("BirdMiniScene \(UserDefaults().integer(forKey: "Currentscore")) ")
        loadScoreScreen()
    }
    func failedGame(){
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") - 50, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        print("BirdMiniScene \(UserDefaults().integer(forKey: "Currentscore")) ")
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Numberoflives") - 1, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        print("BirdMiniScene \(UserDefaults().integer(forKey: "Numberoflives")) ")
        loadScoreScreen()
        
    }
    func loadScoreScreen(){
        
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get ScoreSkview from BirdMini")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"ScoreScene") else {
            print("Could not make ScoreScene from BirdMini")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
}
