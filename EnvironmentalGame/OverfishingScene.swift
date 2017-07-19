//
//  OverfishingScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/12/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit

class OverfishingScene: SKScene, SKPhysicsContactDelegate {
    
    var fish: SKSpriteNode!
    var net: SKSpriteNode!
    var netPosition = CGPoint.zero
    var timeBar: SKSpriteNode!
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
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        fish = self.childNode(withName: "fish") as! SKSpriteNode
        net = self.childNode(withName: "net") as! SKSpriteNode
        
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        fish.physicsBody?.velocity = CGVector(dx: 55, dy: 0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        net.physicsBody?.velocity = CGVector(dx: 60, dy: 0)
        
        // Decrease time
        time -= 0.002
        //Player ran out of time
        if time < 0 {
            loadScreen()
        }
        
        netPosition = net.position
        if netPosition.x > 255{
            net.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        
    }
    
    // Called whenever collision take place
    func didBegin(_ contact: SKPhysicsContact) {
        gameLose()
    }
    func gameLose(){
        
    }
   func loadScreen(){
    }
}
