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
    var forestMainLabel: SKLabelNode!
    var forestLabel: SKLabelNode!
    var human: SKSpriteNode!
    var human2: SKSpriteNode!
    var human3: SKSpriteNode!
    var human4: SKSpriteNode!
    var human5: SKSpriteNode!
    var human6: SKSpriteNode!
    var human7: SKSpriteNode!
    var touchLocation = CGPoint.zero
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
    var countChecker: Int = UserDefaults.standard.integer(forKey: "Countchecker")
    let swing = SKAction(named: "Swing")!
    let swingFlip = SKAction(named: "SwingFlip")!
    
   
    override func didMove(to view: SKView) {
        tree = childNode(withName: "tree") as! SKSpriteNode
        human = childNode(withName: "human") as! SKSpriteNode
        human2 = childNode(withName: "human2") as! SKSpriteNode
        human3 = childNode(withName: "human3") as! SKSpriteNode
        human4 = childNode(withName: "human4") as! SKSpriteNode
        human5 = childNode(withName: "human5") as! SKSpriteNode
        human6 = childNode(withName: "human6") as! SKSpriteNode
        human7 = childNode(withName: "human7") as! SKSpriteNode
        forestMainLabel = self.childNode(withName: "forestMainLabel") as! SKLabelNode
        forestLabel = self.childNode(withName: "forestLabel") as! SKLabelNode
        obstacleLayer = childNode(withName: "obstacleLayer")
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        human.run(swing)
        human2.run(swing)
        human3.run(swing)
        human7.run(swing)
        human4.run(swingFlip)
        human5.run(swingFlip)
        human6.run(swingFlip)
        print("Deforestation Scene loaded, didMove")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        forestMainLabel.isHidden = true
        forestLabel.isHidden = true
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
        if countChecker <= 3{
            time -= 0.0017
            human.physicsBody?.velocity = CGVector(dx: 45, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 45, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 55, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -35, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 35, dy: 0)
        }
        else if countChecker <= 6 && countChecker > 3 {
            time -= 0.0022
            human.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 70, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -40, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -70, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 40, dy: 0)
        }
        else if countChecker <= 9 && countChecker > 6 {
            time -= 0.003
            human.physicsBody?.velocity = CGVector(dx: 65, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 65, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -47, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -65, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -75, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 47, dy: 0)
        }
        else if countChecker <= 12 && countChecker > 9 {
            time -= 0.004
            human.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -75, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
        }
        else if countChecker <= 15 && countChecker > 12 {
            time -= 0.006
            human.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -75, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
        }
        else if countChecker <= 18 && countChecker > 15 {
            time -= 0.0065
            human.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
        }
        else if countChecker <= 21 && countChecker > 18 {
            time -= 0.007
            human.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -105, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
        }
        else if countChecker <= 24 && countChecker > 21 {
            time -= 0.0075
            human.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 115, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -115, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
        }
        else if countChecker <= 27 && countChecker > 24 {
            time -= 0.008
            human.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 120, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -105, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -105, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -120, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
        }
        else if countChecker <= 30 && countChecker > 27 {
            time -= 0.0085
            human.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 125, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -115, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -125, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 115, dy: 0)
        }
        else if countChecker <= 33 && countChecker > 27 {
            time -= 0.009
            human.physicsBody?.velocity = CGVector(dx: 115, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 115, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 135, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -125, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -145, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -135, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 125, dy: 0)
        }
        else if countChecker <= 36 && countChecker > 33 {
            time -= 0.0093
            human.physicsBody?.velocity = CGVector(dx: 125, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 125, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 145, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -125, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -145, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 150, dy: 0)
        }
        else if countChecker <= 39 && countChecker > 36{
            time -= 0.0095
            human.physicsBody?.velocity = CGVector(dx: 135, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 135, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 155, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -145, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -155, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -175, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 145, dy: 0)
        }
        //Player ran out of time
        if time < 0 {
            // print(time)
            completeGame()
        }
    }
    func setRandomPosition(){
                
    }
    func didBegin(_ contact: SKPhysicsContact) {
       
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* Did our hero pass through the 'goal'? */
        if nodeA.name == "tree" || nodeB.name == "tree" {
            print("Deforestation, dead")
            failedGame()
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
