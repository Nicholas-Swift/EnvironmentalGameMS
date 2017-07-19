//
//  BirdMiniScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/10/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit

/* enum BirdMiniSceneState {
    case active, gameOver
} */
class BirdMiniScene: SKScene, SKPhysicsContactDelegate {
    //Top will be electrical wirings
    
    var bird: SKSpriteNode!
    var sinceTouch : CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 100
    var scrollLayer: SKNode!
    var obstacleSource: SKNode!
    var obstacleLayer: SKNode!
    var spawnTimer: CFTimeInterval = 0
    //Game management
    // var gameState: BirdMiniSceneState = .active
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        bird = self.childNode(withName: "bird") as! SKSpriteNode
        scrollLayer = self.childNode(withName: "scrollLayer")
        /* Set reference to obstacle Source node */
        obstacleSource = self.childNode(withName: "obstacle")
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Called when a touch begins
        
        // Disable touch if game no longer active
        /* if gameState != .active {
            print("fml")
            return } */
        
        /* Reset velocity, helps improve response against cumulative falling velocity */
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        // Apply vertical impulse
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
        
        // Apply subtle rotation
        bird.physicsBody?.applyAngularImpulse(1)
        
        // Reset touch timer
        sinceTouch = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
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
        if spawnTimer >= 1.5 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle = obstacleSource.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 600, y: CGFloat.random(min: 75, max: 160))
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        /* Hero touches anything, game over */
        
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
            
        /* Stop any new angular velocity being applied */
        bird.physicsBody?.allowsRotation = false
        
        /* Reset angular velocity */
        bird.physicsBody?.angularVelocity = 0
        
        /* Stop hero flapping animation */
        bird.removeAllActions()
        
        /* Create our hero death action */
        let birdDeath = SKAction.run({
            
            /* Put bird face down in the dirt */
            self.bird.zRotation = CGFloat(-90).degreesToRadians()
        })
        
        /* Run action */
        bird.run(birdDeath)
        }
    }
}
