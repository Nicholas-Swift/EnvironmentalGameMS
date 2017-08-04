//
//  ScoreScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/20/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreScene: SKScene {
    
    var earth1: SKSpriteNode!
    var earth2: SKSpriteNode!
    var earth3: SKSpriteNode!
    var fire1: SKEmitterNode!
    var fire2: SKEmitterNode!
    var fire3: SKEmitterNode!
    var currentScoreLabel: SKLabelNode!
    //var currentLivesLabel: SKLabelNode!
    var currentScoreText: SKLabelNode!
    //var currentLivesText: SKLabelNode!
    var speedUpText: SKLabelNode!
    var animateSpeedUp = SKAction.sequence([SKAction.fadeIn(withDuration: 0.3), SKAction.fadeOut(withDuration: 0.3)])
    var countChecker: Int = UserDefaults.standard.integer(forKey: "Countchecker")
    var livesForEarth: Int = UserDefaults.standard.integer(forKey: "Numberoflives")
    var randomNumberFirst: Int {
        get {
            if let storedRandomNumberFirst = UserDefaults.standard.object(forKey: "Randomnumberfirst") as? Int {
                return storedRandomNumberFirst
            }
            return 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Randomnumberfirst")
            UserDefaults.standard.synchronize()
        }
    }
    
    var randomNumberSecond: Int {
        get {
            if let storedRandomNumberSecond = UserDefaults.standard.object(forKey: "Randomnumbersecond") as? Int {
                return storedRandomNumberSecond
            }
            return 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
        }
    }
    override func didMove(to view: SKView) {
        let firstDuration = 0.7
        let duration = 2.0
        earth1 = childNode(withName: "earth1") as! SKSpriteNode
        earth2 = childNode(withName: "earth2") as! SKSpriteNode
        earth3 = childNode(withName: "earth3") as! SKSpriteNode
        fire1 = earth1.childNode(withName: "fire1") as! SKEmitterNode
        fire2 = earth2.childNode(withName: "fire2") as! SKEmitterNode
        fire3 = earth3.childNode(withName: "fire3") as! SKEmitterNode
        hideFire()
        
        if livesForEarth == 1 {
            fire1.isHidden = false
        }
        if livesForEarth == 0 {
            fire1.isHidden = false
            fire2.isHidden = false
        }
        currentScoreLabel = childNode(withName: "currentScoreLabel") as! SKLabelNode
        currentScoreText = childNode(withName: "currentScoreText") as! SKLabelNode
        currentScoreLabel.text = String(UserDefaults.standard.integer(forKey: "Currentscore"))
        speedUpText = childNode(withName: "speedUpText") as! SKLabelNode
        speedUpText.isHidden = true
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "Countchecker") + 1, forKey: "Countchecker")
        UserDefaults.standard.synchronize()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + firstDuration){
            if self.livesForEarth == 2 {
                self.fire1.isHidden = false
                
            }
            if self.livesForEarth == 1{
                self.fire2.isHidden = false
                
            }
            if self.livesForEarth == 0 {
                self.fire3.isHidden = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                    self.loadGameOver()
                }
            }
            
        }
        if livesForEarth == 0 {return}
        
        if countChecker % 3 == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.currentScoreText.isHidden = true
                self.currentScoreLabel.isHidden = true
                self.earth1.isHidden = true
                self.earth2.isHidden = true
                self.earth3.isHidden = true
                //self.currentLivesText.isHidden = true
                //self.currentLivesLabel.isHidden = true
                self.speedUpText.isHidden = false
                self.speedUpText.run(SKAction.repeatForever(self.animateSpeedUp))
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.speedUpText.removeAllActions()
                    self.generateRandomScene()
                }
            }
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                self.generateRandomScene()
            }
        }
        
    }
    func hideFire(){
        fire1.isHidden = true
        fire2.isHidden = true
        fire3.isHidden = true
    }
    func loadGameOver(){
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"GameOverScene") else {
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
    
     public func generateRandomScene() {
        let randomNumber = arc4random_uniform(100)
        if randomNumber <= 20{
            randomNumberSecond = 1
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        else if randomNumber > 20 && randomNumber <= 40 {
            randomNumberSecond = 2
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        else if randomNumber > 40 && randomNumber <= 60 {
            randomNumberSecond = 3
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        else if randomNumber > 60 && randomNumber <= 80{
            randomNumberSecond = 4
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        else if randomNumber > 80 && randomNumber <= 100{
            randomNumberSecond = 5
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        //print(randomNumberSecond)
        //print(UserDefaults().integer(forKey: "Randomnumbersecond"))
    }
    public func loadRandomScene(){
        if randomNumberSecond != randomNumberFirst{
            if randomNumberSecond == 1 {
                /* 1) Grab reference to our SpriteKit view */
                guard let skView = self.view as SKView! else {
                    print("Could not get Skview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"BirdMiniScene") else {
                    print("Could not make GameScene, check the name is spelled correctly")
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
            else if randomNumberSecond == 2 {
                /* 1) Grab reference to our SpriteKit view */
                guard let skView = self.view as SKView! else {
                    print("Could not get Skview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"OverfishingScene") else {
                    print("Could not make GameScene, check the name is spelled correctly")
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
            else if randomNumberSecond == 3{
                /* 1) Grab reference to our SpriteKit view */
                guard let skView = self.view as SKView! else {
                    print("Could not get Skview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"IceMeltingScene") else {
                    print("Could not make GameScene, check the name is spelled correctly")
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
            else if randomNumberSecond == 4{
                /* 1) Grab reference to our SpriteKit view */
                guard let skView = self.view as SKView! else {
                    print("Could not get Skview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"DeforestationScene") else {
                    print("Could not make GameScene, check the name is spelled correctly")
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
            else if randomNumberSecond == 5{
                /* 1) Grab reference to our SpriteKit view */
                guard let skView = self.view as SKView! else {
                    print("Could not get Skview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"AirPollution") else {
                    print("Could not make GameScene, check the name is spelled correctly")
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
        else{
            generateRandomScene()
        }
        randomNumberFirst = randomNumberSecond
        UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumberfirst")
        UserDefaults.standard.synchronize()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
