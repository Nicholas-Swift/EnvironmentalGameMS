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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Called when a touch begins
        
        // Reset velocity, helps improve response against cumulative falling velocity
        polarBear.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        polarBearPosition = polarBear.position
        if polarBearPosition.y <= 127{
            polarBear.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 550))
            //print(polarBearPosition)
            //print(polarBear.position.x)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
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
        if spawnTimer >= 2.5 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle = obstacleSource.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x:CGFloat.random(min: 75, max: 560) , y: 50 )
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
       gameover()
    }
    func gameover(){
        print("dead")
    }
}
