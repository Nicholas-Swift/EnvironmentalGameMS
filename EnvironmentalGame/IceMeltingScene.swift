//
//  IceMeltingScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/13/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//


import SpriteKit

class IceMeltingScene: SKScene, SKPhysicsContactDelegate {
    //Top will be electrical wirings
    
    var polarBear: SKSpriteNode!
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 200
    var scrollLayer: SKNode!
    var obstacleSource: SKNode!
    var obstacleLayer: SKNode!
    var spawnTimer: CFTimeInterval = 0
    var polarBearPosition = CGPoint.zero
    var timeBar: SKSpriteNode!
    var iceMainLabel: SKLabelNode!
    var iceLabel: SKLabelNode!
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
    var polarState : Bool = true
    let polarBearJump = SKAction(named: "PolarBearJump")!
    let polarBearDead = SKAction(named: "PolarBearDead")!
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        polarBear = self.childNode(withName: "polarBear") as! SKSpriteNode
        scrollLayer = self.childNode(withName: "scrollLayer")
        /* Set reference to obstacle Source node */
        obstacleSource = self.childNode(withName: "obstacle")
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        iceMainLabel = self.childNode(withName: "iceMainLabel") as! SKLabelNode
        iceLabel = self.childNode(withName: "iceLabel") as! SKLabelNode
        polarBear.run(polarBearJump)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Called when a touch begins
        iceMainLabel.isHidden = true
        iceLabel.isHidden = true
        
        // Reset velocity, helps improve response against cumulative falling velocity
        polarBear.physicsBody?.velocity = CGVector(dx: 0, dy: 125)
        
        polarBearPosition = polarBear.position
        if polarBearPosition.y <= 127{
            polarBear.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 550))
            //print(polarBearPosition)
            //print(polarBear.position.x)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if polarState == false { return }
        /* Grab current velocity */
        let velocityY = polarBear.physicsBody?.velocity.dy ?? 0
        
        /* Check and cap vertical velocity */
        if velocityY > 550 {
            polarBear.physicsBody?.velocity.dy = 550
        }
        // Process world scrolling
        scrollWorld()
        
        /* Process obstacles */
        updateObstacles()
        
        spawnTimer += fixedDelta
        
        if countChecker <= 3{
            time -= 0.0017
        }
        else if countChecker <= 6 && countChecker > 3 {
            time -= 0.0022
        }
        else if countChecker <= 9 && countChecker > 6 {
            time -= 0.003
        }
        else if countChecker <= 12 && countChecker > 9 {
            time -= 0.004
        }
        else if countChecker <= 15 && countChecker > 12 {
            time -= 0.006
        }
        else if countChecker <= 18 && countChecker > 15 {
            time -= 0.0065
        }
        else if countChecker <= 21 && countChecker > 18 {
            time -= 0.007
        }
        else if countChecker <= 24 && countChecker > 21 {
            time -= 0.0075
        }
        else if countChecker <= 27 && countChecker > 24 {
            time -= 0.008
        }
        else if countChecker <= 30 && countChecker > 27 {
            time -= 0.0085
        }
        else if countChecker <= 33 && countChecker > 27 {
            time -= 0.009
        }
        else if countChecker <= 36 && countChecker > 33 {
            time -= 0.0093
        }
        else if countChecker <= 39 && countChecker > 36{
            time -= 0.0095
        }
        //Player ran out of time
        if time < 0 {
            completeGame()
        }
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
            
            /* Wow bug fixes */
            obstacle.name = "obstacle"
            
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
        if spawnTimer >= 1.5 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle = obstacleSource.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x:CGFloat.random(min: 75, max: 560) , y: 25)
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        /* Get references to bodies involved in collision */
        let duration = 1.5
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* Did our hero pass through the 'goal'? */
        if nodeA.name == "obstacle" || nodeB.name == "obstacle" {
            print("Dead")
            polarState = false
            polarBear.position.x = obstacleSource.position.x
            polarBear.position.y = 95
            polarBear.texture = SKTexture(imageNamed: "PolarBearDead@1x")
            polarBear.run(polarBearDead)
             DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
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
