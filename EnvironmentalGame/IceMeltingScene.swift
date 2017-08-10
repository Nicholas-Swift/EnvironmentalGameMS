//
//  IceMeltingScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/13/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//


import SpriteKit
import AVFoundation

class IceMeltingScene: SKScene, SKPhysicsContactDelegate {
    //Top will be electrical wirings
    
    var audioPlayer = AVAudioPlayer()
    var polarBear: SKSpriteNode!
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 200
    var scrollLayer: SKNode!
    var obstacleSource: SKNode!
    var obstacleLayer: SKNode!
    var spawnTimer: CFTimeInterval = 0
    var polarBearPosition = CGPoint.zero
    /* var firstObstaclePosition = CGPoint.zero
    var secondObstaclePosition = CGPoint.zero
    var newSecondObstaclePosition = CGPoint.zero
    var randomPosition = CGPoint.zero */
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
    let polarJumpSound = SKAction(named: "PolarJumpSound")!
    
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
        polarBear = self.childNode(withName: "polarBear") as! SKSpriteNode
        scrollLayer = self.childNode(withName: "scrollLayer")
        /* Set reference to obstacle Source node */
        obstacleSource = self.childNode(withName: "obstacle")
        // firstObstaclePosition = obstacleSource.position
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        iceMainLabel = self.childNode(withName: "iceMainLabel") as! SKLabelNode
        iceLabel = self.childNode(withName: "iceLabel") as! SKLabelNode
        print("Overfishing \(UserDefaults().integer(forKey: "Currentscore")) current score")
        polarBear.run(polarBearJump)
        print("IceMelting \(countChecker) count checker")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Called when a touch begins
        if polarState == false {return}
        iceMainLabel.isHidden = true
        iceLabel.isHidden = true
        
        // Reset velocity, helps improve response against cumulative falling velocity
        polarBear.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        polarBearPosition = polarBear.position
        if polarBearPosition.y <= 127{
            polarBear.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 550))
            polarBear.run(polarJumpSound)
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
        
        time -= 0.0017
        
        if countChecker >= 6 && countChecker < 9 {
            time -= 0.001
        }
        
        if countChecker >= 9 {
            time -= 0.0005
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
       /* if countChecker > 6 {
            
            if spawnTimer >= 1.0 {
                
                /* Create a new obstacle by copying the source obstacle */
                let newObstacle = obstacleSource.copy() as! SKNode
                obstacleLayer.addChild(newObstacle)
                
                let randomPosition = CGPoint(x:310 , y: 25)
                
                /* Convert new node position back to obstacle layer space */
                newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            }
        }
        else {*/
            /* Time to add a new obstacle? */
            if spawnTimer >= 1.5 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle = obstacleSource.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            let randomPosition = CGPoint(x: 310 , y: 25)
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
            
           /* generateRandomPosition()
            
            if (secondObstaclePosition != firstObstaclePosition) && (Float(secondObstaclePosition.x) > Float(firstObstaclePosition.x + 310) || Float(secondObstaclePosition.x) < Float(firstObstaclePosition.x - 310)) {
                
                print("first position \(firstObstaclePosition)")
                /* Convert new node position back to obstacle layer space */
                newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
                
                firstObstaclePosition = secondObstaclePosition
                
            }
            else {
                //let randomNumber = arc4random_uniform(100)
                //if randomNumber <= 50 {
                    newSecondObstaclePosition = CGPoint(x: firstObstaclePosition.x + 310, y:firstObstaclePosition.y)
                    newObstacle.position = self.convert(newSecondObstaclePosition, to: obstacleLayer)
               // }
                /*if randomNumber > 50 {
                    newSecondObstaclePosition = CGPoint(x: firstObstaclePosition.x - 310, y:firstObstaclePosition.y)
                    newObstacle.position = self.convert(newSecondObstaclePosition, to: obstacleLayer)
                }*/
                firstObstaclePosition = secondObstaclePosition
            }
            // Reset spawn timer
            spawnTimer = 0 */
            //}
        }
        
    }
    
    /* func generateRandomPosition(){
        
        /* Generate new obstacle position, start just outside screen and with a random y value */
        randomPosition = CGPoint(x:CGFloat.random(min: 110, max: 560) , y: 25)
        secondObstaclePosition = randomPosition
        print("second position \(secondObstaclePosition)")
        
    } */
    
    func didBegin(_ contact: SKPhysicsContact) {
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        
        if nodeA.name == "deathObstacle" || nodeB.name == "deathObstacle" {
            print("Polar Bear is Dead")
            polarBear.removeAllActions()
            polarState = false
            
            let polarTemp : SKPhysicsBody = (polarBear.physicsBody)!
            polarBear!.physicsBody = nil
            polarBear.position.x = polarBearPosition.x + 115
            polarBear.position.y = 95
            polarBear.texture = SKTexture(imageNamed: "PolarBearDead@1x")
            
            let polarFailedGame = SKAction.run({
                self.failedGame()
            })
            audioPlayer.stop()
            let polarDeadSequence = SKAction.sequence([polarBearDead, polarFailedGame])
            polarBear.run(polarDeadSequence)
            polarBear.physicsBody? = polarTemp
            print(polarBear.position)
        }
    }
    func completeGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") + 50, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        print("IceMelting \(UserDefaults().integer(forKey: "Currentscore")) current score")
        loadScoreScreen()
    }
    func failedGame(){
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") - 50, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        print("IceMelting \(UserDefaults().integer(forKey: "Currentscore")) current score")
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Numberoflives") - 1, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        print("IceMelting \(UserDefaults().integer(forKey: "Numberoflives")) number of lives" )
        loadScoreScreen()
        
    }
    func loadScoreScreen(){
        
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get ScoreSkview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"ScoreScene") else {
            print("Could not make ScoreScene")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFit
        
        /* Show debug */
        skView.showsPhysics = false
        skView.showsDrawCount = false
        skView.showsFPS = false
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
