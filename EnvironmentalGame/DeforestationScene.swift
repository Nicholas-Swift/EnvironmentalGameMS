//
//  DeforestationScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/17/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit

class DeforestationScene: SKScene, SKPhysicsContactDelegate {
    
    var tree: SKSpriteNode!
    var spawnTimer: CFTimeInterval = 0
    var obstacleLayer: SKNode!
    var countHuman: Int = 0
    var human: SKSpriteNode!
    var human2: SKSpriteNode!
    var human3: SKSpriteNode!
    var human4: SKSpriteNode!
    var human5: SKSpriteNode!
    var human6: SKSpriteNode!
    var human7: SKSpriteNode!
    var touchLocation = CGPoint.zero
   
    override func didMove(to view: SKView) {
        tree = childNode(withName: "tree") as! SKSpriteNode
        human = childNode(withName: "human") as! SKSpriteNode
        human2 = childNode(withName: "human2") as! SKSpriteNode
        human3 = childNode(withName: "human3") as! SKSpriteNode
        human4 = childNode(withName: "human4") as! SKSpriteNode
        human5 = childNode(withName: "human5") as! SKSpriteNode
        human6 = childNode(withName: "human6") as! SKSpriteNode
        human7 = childNode(withName: "human7") as! SKSpriteNode
        obstacleLayer = childNode(withName: "obstacleLayer")
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.location(in: self)
            if human.contains(touchLocation) {
                human.position.x = touchLocation.x - 30
                
            }
            else if human2.contains(touchLocation) {
                human2.position.x = touchLocation.x - 30
                
            }
            else if human3.contains(touchLocation) {
                human3.position.x = touchLocation.x - 30
                
            }
            else if human4.contains(touchLocation) {
                human4.position.x = touchLocation.x + 30
            }
            else if human5.contains(touchLocation) {
                human5.position.x = touchLocation.x + 30
            }
            else if human6.contains(touchLocation) {
                human6.position.x = touchLocation.x + 30
            }
            else if human7.contains(touchLocation) {
                human7.position.x = touchLocation.x - 30
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        human.physicsBody?.velocity = CGVector(dx: 55, dy: 0)
        human2.physicsBody?.velocity = CGVector(dx: 55, dy: 0)
        human3.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
        human4.physicsBody?.velocity = CGVector(dx: -45, dy: 0)
        human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
        human6.physicsBody?.velocity = CGVector(dx: -75, dy: 0)
        human7.physicsBody?.velocity = CGVector(dx: 45, dy: 0)
    }
    func setRandomPosition(){
                
    }
    func didBegin(_ contact: SKPhysicsContact) {
        gameLose()
    }
    func gameLose(){
        loadScreen()
    }
    func loadScreen(){
        //load score screen
        print("ok")
    }

}
