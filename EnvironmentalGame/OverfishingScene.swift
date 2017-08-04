//
//  OverfishingScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/12/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit

/*enum OverfishingSceneState {
    case active, notActive
}*/

class OverfishingScene: SKScene, SKPhysicsContactDelegate {
    
    var fish: SKSpriteNode!
    var fishState: Bool = true
    var fishPosition = CGPoint.zero
    var net: SKSpriteNode!
    var netPosition = CGPoint.zero
    var timeBar: SKSpriteNode!
    var overfishingMainLabel: SKLabelNode!
    var overfishingLabel: SKLabelNode!
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
    var countChecker: Int = 0
    
    let fishSwim = SKAction(named: "FishSwim")!
    let fishDead = SKAction(named: "FishDeadAction")!
    let duration = 2.0
    
    //Game management
    //var gameState: OverfishingSceneState = .active
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        fish = self.childNode(withName: "fish") as! SKSpriteNode
        net = self.childNode(withName: "net") as! SKSpriteNode
        fish.run(fishSwim)
        
        overfishingMainLabel = self.childNode(withName: "overfishingMainLabel") as! SKLabelNode
        overfishingLabel = self.childNode(withName: "overfishingLabel") as! SKLabelNode
        
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        countChecker = UserDefaults.standard.integer(forKey: "Countchecker")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        overfishingMainLabel.isHidden = true
        overfishingLabel.isHidden = true
        if fishState == false {return}
        fish.physicsBody?.velocity = CGVector(dx: 55, dy: 0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if fishState == false { return }

        if countChecker <= 3{
            time -= 0.0017
            net.physicsBody?.velocity = CGVector(dx: 57, dy: 0)
        }
        else if countChecker <= 6 && countChecker > 3 {
            time -= 0.0022
            net.physicsBody?.velocity = CGVector(dx: 60, dy: 0)
        }
        else if countChecker <= 9 && countChecker > 6 {
            time -= 0.003
            net.physicsBody?.velocity = CGVector(dx: 65, dy: 0)
        }
        else if countChecker <= 12 && countChecker > 9 {
            time -= 0.004
            net.physicsBody?.velocity = CGVector(dx: 70, dy: 0)
        }
        else if countChecker <= 15 && countChecker > 12 {
            time -= 0.006
            net.physicsBody?.velocity = CGVector(dx: 75, dy: 0)
        }
        else if countChecker <= 18 && countChecker > 15 {
            time -= 0.0065
            net.physicsBody?.velocity = CGVector(dx: 80, dy: 0)
        }
        else if countChecker <= 21 && countChecker > 18 {
            time -= 0.007
            net.physicsBody?.velocity = CGVector(dx: 85, dy: 0)
        }
        else if countChecker <= 24 && countChecker > 21 {
            time -= 0.0075
            net.physicsBody?.velocity = CGVector(dx: 90, dy: 0)
        }
        else if countChecker <= 27 && countChecker > 24 {
            time -= 0.008
            net.physicsBody?.velocity = CGVector(dx: 95, dy: 0)
        }
        else if countChecker <= 30 && countChecker > 27 {
            time -= 0.0085
            net.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        }
        else if countChecker <= 33 && countChecker > 27 {
            time -= 0.009
            net.physicsBody?.velocity = CGVector(dx: 105, dy: 0)
        }
        else if countChecker <= 36 && countChecker > 33 {
            time -= 0.0093
            net.physicsBody?.velocity = CGVector(dx: 110, dy: 0)
        }
        else if countChecker <= 39 && countChecker > 36{
            time -= 0.0095
            net.physicsBody?.velocity = CGVector(dx: 115, dy: 0)
        }
        //Player ran out of time
        if time < 0 {
            completeGame()
        }
        fishPosition = fish.position
        if fishPosition.x > 333 {
            completeGame()
        }
        netPosition = net.position
        if netPosition.x > 255{
            net.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        
    }
    
    // Called whenever collision take place
    func didBegin(_ contact: SKPhysicsContact) {
        fish.run(fishDead)
        fishState = false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration){
            self.failedGame()
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
        print("Overfishing \( UserDefaults().integer(forKey: "Numberoflives"))")
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
