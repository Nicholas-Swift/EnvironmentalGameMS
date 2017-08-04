//
//  BirdMiniScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/10/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit

/*enum BirdMiniSceneState {
    case active, notActive
} */
class BirdMiniScene: SKScene, SKPhysicsContactDelegate {
    //Top will be electrical wirings
    
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
        bird.run(birdFlap)
        if countChecker < 6 {
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Called when a touch begins
        birdMiniMainLabel.isHidden = true
        birdMiniLabel.isHidden = true
        
        if birdState == false {return}
        
        bird.physicsBody?.affectedByGravity = true
        bird.physicsBody? .isDynamic = true
        
        /* Reset velocity, helps improve response against cumulative falling velocity */
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        // Apply vertical impulse
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        
        // Apply subtle rotation
        bird.physicsBody?.applyAngularImpulse(1)
        
        // Reset touch timer
        sinceTouch = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if birdState == false {return}
        
        if countChecker <= 3{
            time -= 0.0017
        }
        else if countChecker <= 6 && countChecker > 3 {
            time -= 0.0022
            fixedDelta = 1.0 / 80.0
        }
        else if countChecker <= 9 && countChecker > 6 {
            time -= 0.003
            fixedDelta = 1.0 / 82.0
        }
        else if countChecker <= 12 && countChecker > 9 {
            time -= 0.004
            fixedDelta = 1.0 / 85.0
        }
        else if countChecker <= 15 && countChecker > 12 {
            time -= 0.006
            fixedDelta = 1.0 / 87.0
        }
        else if countChecker <= 18 && countChecker > 15 {
            time -= 0.0065
            fixedDelta = 1.0 / 90.0
        }
        else if countChecker <= 21 && countChecker > 18 {
            time -= 0.007
            fixedDelta = 1.0 / 92.0
        }
        else if countChecker <= 24 && countChecker > 21 {
            time -= 0.0075
            fixedDelta = 1.0 / 93.0
        }
        else if countChecker <= 27 && countChecker > 24 {
            time -= 0.008
            fixedDelta = 1.0 / 95.0
        }
        else if countChecker <= 30 && countChecker > 27 {
            time -= 0.0085
            fixedDelta = 1.0 / 97.0
        }
        else if countChecker <= 33 && countChecker > 27 {
            time -= 0.009
            fixedDelta = 1.0 / 99.0
        }
        else if countChecker <= 36 && countChecker > 33 {
            time -= 0.0093
            fixedDelta = 1.0 / 100.0
        }
        else if countChecker <= 39 && countChecker > 36{
            time -= 0.0095
            fixedDelta = 1.0 / 101.0
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
        if spawnTimer >= 1.0 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle = obstacleSource.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 380, y: CGFloat.random(min: 55, max: 195))
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        /* Hero touches anything, game over */
        
        let duration = 2.0
        
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* Did our hero pass through the 'goal'? */
        if nodeA.name == "goal" || nodeB.name == "goal" {
            print("Surviving")
        }
        
        /*/* Ensure only called while game running */
        if gameState != .active { return }
        
        /* Change game state to game over */
        gameState = .gameOver */
            
        else {
        print("dead")
            
        bird.run(birdHit)
        
        birdState = false
        //gameState = .notActive
            
        bird.physicsBody?.isDynamic = false
            
        /* Stop any new angular velocity being applied */
        bird.physicsBody?.allowsRotation = false
        
        /* Reset angular velocity */
        bird.physicsBody?.angularVelocity = 0
        
        //failedGame()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration){
            self.failedGame()
            }
        }
    }
    func completeGame(){
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") + 50, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        print(UserDefaults().integer(forKey: "Currentscore"))
        loadScoreScreen()
    }
    func failedGame(){
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") - 50, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        print(UserDefaults().integer(forKey: "Currentscore"))
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Numberoflives") - 1, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        print(UserDefaults().integer(forKey: "Numberoflives"))
        loadScoreScreen()
        
    }
    func loadScoreScreen(){
        
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"ScoreScene") else {
            print("Could not make GameScene")
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
