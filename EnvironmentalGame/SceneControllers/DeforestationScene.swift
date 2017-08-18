//
//  DeforestationScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/17/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import AVFoundation

class DeforestationScene: SKScene, SKPhysicsContactDelegate {
    
    var audioPlayer = AVAudioPlayer()
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
    var human8: SKSpriteNode!
    var human9: SKSpriteNode!
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
    var treeState: Bool = true
    var countChecker: Int = UserDefaults.standard.integer(forKey: "Countchecker")
    let swing = SKAction(named: "Swing")!
    let swingFlip = SKAction(named: "SwingFlip")!
    let treeCut = SKAction(named: "TreeCut")!
    
   
    override func didMove(to view: SKView) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hustle", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error in loading Start Scene Background music")
        }
        audioPlayer.play()
        
        tree = childNode(withName: "tree") as! SKSpriteNode
        human = childNode(withName: "human") as! SKSpriteNode
        human2 = childNode(withName: "human2") as! SKSpriteNode
        human3 = childNode(withName: "human3") as! SKSpriteNode
        human4 = childNode(withName: "human4") as! SKSpriteNode
        human5 = childNode(withName: "human5") as! SKSpriteNode
        human6 = childNode(withName: "human6") as! SKSpriteNode
        human7 = childNode(withName: "human7") as! SKSpriteNode
        human8 = childNode(withName: "human8") as! SKSpriteNode
        human9 = childNode(withName: "human9") as! SKSpriteNode
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
        human8.run(swing)
        human4.run(swingFlip)
        human5.run(swingFlip)
        human6.run(swingFlip)
        human9.run(swingFlip)
        
        human8.physicsBody?.isDynamic = false
        human8.isHidden = true
        human9.physicsBody?.isDynamic = false
        human9.isHidden = true
        print("Deforestation Scene loaded, didMove")
        print("Deforestation \(countChecker) count checker")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if treeState == false { return }
        for touch in touches {
            touchLocation = touch.location(in: self)
            if human.contains(touchLocation) {
               // print(human.position.x)
                if human.position.x <  -(self.size.width / 2) + 10 {
                    human.position.x = -(self.size.width / 2) + 10
                }
                human.position.x = touchLocation.x - 20
                
            }
            else if human2.contains(touchLocation) {
                if human2.position.x < -(self.size.width / 2) + 10 {
                    human2.position.x = -(self.size.width / 2) + 10
                }
                human2.position.x = touchLocation.x - 20
            }
            else if human3.contains(touchLocation) {
                if human3.position.x < -(self.size.width / 2) + 10 {
                    human3.position.x = -(self.size.width / 2 ) + 10
                }
                human3.position.x = touchLocation.x - 20
            }
            else if human4.contains(touchLocation) {
                if human4.position.x > (self.size.width / 2) - 10 {
                    human4.position.x = (self.size.width / 2) - 10
                }
                human4.position.x = touchLocation.x + 20
            }
            else if human5.contains(touchLocation) {
                if human5.position.x > (self.size.width / 2) - 10{
                    human5.position.x = (self.size.width / 2) - 10
                }
                human5.position.x = touchLocation.x + 20
            }
            else if human6.contains(touchLocation) {
                if human6.position.x > (self.size.width / 2) - 10{
                    human6.position.x = (self.size.width / 2) - 10
                }
                human6.position.x = touchLocation.x + 20
            }
            else if human7.contains(touchLocation) {
                if human7.position.x < -(self.size.width / 2) + 10{
                    human7.position.x = -(self.size.width) + 10
                }
                human7.position.x = touchLocation.x - 20
            }
            else if human8.contains(touchLocation) {
                if human8.position.x < -(self.size.width / 2) + 10 {
                    human8.position.x = -(self.size.width / 2 ) + 10
                }
                human8.position.x = touchLocation.x - 20
            }
            else if human9.contains(touchLocation) {
                if human9.position.x > (self.size.width / 2) - 10 {
                    human9.position.x = (self.size.width / 2) - 10
                }
                human9.position.x = touchLocation.x + 20
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        if treeState == false { return }
        
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
            time -= 0.002
            human.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 70, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -40, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -70, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 40, dy: 0)
        }
        else if countChecker <= 9 && countChecker > 6 {
            time -= 0.0022
            human.physicsBody?.velocity = CGVector(dx: 65, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 65, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -47, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -65, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -75, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 47, dy: 0)
            
            human8.physicsBody?.isDynamic = true
            human8.isHidden = false
            human8.physicsBody?.velocity = CGVector(dx: 90, dy: 0)
            human9.physicsBody?.isDynamic = true
            human9.isHidden = false
            human9.physicsBody?.velocity = CGVector(dx: -90, dy: 0)
        }
        else if countChecker <= 12 && countChecker > 9 {
            time -= 0.0024
            human.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -75, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
            
            human8.physicsBody?.isDynamic = true
            human8.isHidden = false
            human8.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
            human9.physicsBody?.isDynamic = true
            human9.isHidden = false
            human9.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        }
        else if countChecker <= 15 && countChecker > 12 {
            time -= 0.0025
            human.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -75, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            
            human8.physicsBody?.isDynamic = true
            human8.isHidden = false
            human8.physicsBody?.velocity = CGVector(dx: 90, dy: 0)
            human9.physicsBody?.isDynamic = true
            human9.isHidden = false
            human9.physicsBody?.velocity = CGVector(dx: -90, dy: 0)
        }
        else if countChecker <= 18 && countChecker > 15 {
            time -= 0.0026
            human.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            
            human8.physicsBody?.isDynamic = true
            human8.isHidden = false
            human8.physicsBody?.velocity = CGVector(dx: 90, dy: 0)
            human9.physicsBody?.isDynamic = true
            human9.isHidden = false
            human9.physicsBody?.velocity = CGVector(dx: -90, dy: 0)
        }
        else if countChecker <= 21 && countChecker > 18 {
            time -= 0.0027
            human.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -105, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
            
            human8.physicsBody?.isDynamic = true
            human8.isHidden = false
            human8.physicsBody?.velocity = CGVector(dx: 90, dy: 0)
            human9.physicsBody?.isDynamic = true
            human9.isHidden = false
            human9.physicsBody?.velocity = CGVector(dx: -90, dy: 0)
        }
            
        else if countChecker <= 24 && countChecker > 21 {
            time -= 0.0028
            human.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 115, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -95, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -85, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -115, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
        }
        else if countChecker <= 27 && countChecker > 24 {
            time -= 0.0029
            human.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 120, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -105, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -105, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -120, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
        }
        else {
            time -= 0.003
            human.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human2.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
            human3.physicsBody?.velocity = CGVector(dx: 125, dy: 0)
            human4.physicsBody?.velocity = CGVector(dx: -115, dy: 0)
            human5.physicsBody?.velocity = CGVector(dx: -55, dy: 0)
            human6.physicsBody?.velocity = CGVector(dx: -125, dy: 0)
            human7.physicsBody?.velocity = CGVector(dx: 115, dy: 0)
        }
        if time <= 0.9 {
            forestMainLabel.isHidden = true
            forestLabel.isHidden = true
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
        
        if nodeA.name == "tree" || nodeB.name == "tree" {
            print("Deforestation, dead")
            treeState = false
            
            human.removeAllActions()
            human2.removeAllActions()
            human3.removeAllActions()
            human4.removeAllActions()
            human5.removeAllActions()
            human6.removeAllActions()
            human7.removeAllActions()
            human8.removeAllActions()
            human9.removeAllActions()
            
            human.physicsBody?.isDynamic = false
            human2.physicsBody?.isDynamic = false
            human3.physicsBody?.isDynamic = false
            human4.physicsBody?.isDynamic = false
            human5.physicsBody?.isDynamic = false
            human6.physicsBody?.isDynamic = false
            human7.physicsBody?.isDynamic = false
            human8.physicsBody?.isDynamic = false
            human9.physicsBody?.isDynamic = false
            
            let treeFailedGame = SKAction.run({
                self.failedGame()
            })
            let treeWait = SKAction.wait(forDuration: 0.7)
            let treeDeathSequence = SKAction.sequence([treeCut, treeWait, treeFailedGame])
            audioPlayer.stop()
            tree.run(treeDeathSequence)
        }
    }
    func completeGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(true, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
        print("DeforestationScene \(UserDefaults().bool(forKey: "Winorlose")) ")
        loadScoreScreen()
    }
    func failedGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(false, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
        print("DeforestationScene \(UserDefaults().bool(forKey: "Winorlose")) ")
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Numberoflives") - 1, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        print("Deforestation \(UserDefaults().integer(forKey: "Numberoflives")) number of lives")
        loadScoreScreen()
        
    }
    func loadScoreScreen(){
        // 1) Grab reference to our SpriteKit view
        guard let skView = self.view as SKView! else {
            print("Could not get ScoreSkview")
            return
        }
        
        // 2) Load Game scene
        guard let scene = SKScene(fileNamed:"ScoreScene") else {
            print("Could not make ScoreScene")
            return
        }
        
        // 3) Ensure correct aspect mode
        scene.scaleMode = .aspectFit
        
        // Show debug
        skView.showsPhysics = false
        skView.showsDrawCount = false
        skView.showsFPS = false
        
        // 4) Start game scene 
        skView.presentScene(scene)
    }
}
