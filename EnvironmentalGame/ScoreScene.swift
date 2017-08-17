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
    var currentScoreText: SKLabelNode!
    var speedUpText: SKLabelNode!
    var animateSpeedUp = SKAction.sequence([SKAction.fadeIn(withDuration: 0.3), SKAction.fadeOut(withDuration: 0.3),SKAction.fadeIn(withDuration: 0.3), SKAction.fadeOut(withDuration: 0.3), SKAction.fadeIn(withDuration: 0.3), SKAction.fadeOut(withDuration: 0.3)])
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
    var winOrLose = UserDefaults.standard.bool(forKey: "Winorlose")
    
    let shortWait = SKAction.wait(forDuration: 0.5)
    let longWait = SKAction.wait(forDuration: 1.0)
    let earthFire = SKAction(named: "EarthFire")!
    let winSound = SKAction(named: "WinSound")!
    let loseSound = SKAction(named: "LoseSound")!
    
    
    override func didMove(to view: SKView) {
        earth1 = childNode(withName: "earth1") as! SKSpriteNode
        earth2 = childNode(withName: "earth2") as! SKSpriteNode
        earth3 = childNode(withName: "earth3") as! SKSpriteNode
        fire1 = earth1.childNode(withName: "fire1") as! SKEmitterNode
        fire2 = earth2.childNode(withName: "fire2") as! SKEmitterNode
        fire3 = earth3.childNode(withName: "fire3") as! SKEmitterNode
        hideFire()
        
        currentScoreLabel = childNode(withName: "currentScoreLabel") as! SKLabelNode
        currentScoreText = childNode(withName: "currentScoreText") as! SKLabelNode
        speedUpText = childNode(withName: "speedUpText") as! SKLabelNode
        speedUpText.isHidden = true
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "Countchecker") + 1, forKey: "Countchecker")
        UserDefaults.standard.synchronize()
        print("ScoreScene \(UserDefaults.standard.integer(forKey: "Countchecker")) count checker")
        currentScoreLabel.text = String(UserDefaults.standard.integer(forKey: "Currentscore"))
        
        let updateScore = SKAction.run ({
            self.currentScoreLabel.text = String(UserDefaults.standard.integer(forKey: "Currentscore"))
        })
        let lightEarthOnFire = SKAction.run ({
            if self.livesForEarth == 2 {
                self.fire1.isHidden = false
                self.run(self.earthFire)
                
            }
            if self.livesForEarth == 1{
                self.fire1.isHidden = false
                self.fire2.isHidden = false
                self.run(self.earthFire)
                
            }
            if self.livesForEarth == 0 {
                self.fire1.isHidden = false
                self.fire2.isHidden = false
                self.fire3.isHidden = false
                let loadOver = SKAction.run ({
                    self.run(self.earthFire)
                    self.loadGameOver()
                })
            let loadOverSequence = SKAction.sequence([self.longWait, loadOver])
                self.run(loadOverSequence)
            }
        })
        let nextAction = SKAction.run({
            self.nextActionAfterWait()
        })
        
        let scoreLoseSequence = SKAction.sequence([shortWait, lightEarthOnFire, loseSound, updateScore, longWait, nextAction])
        let scoreWinSequence = SKAction.sequence([shortWait, winSound, updateScore, longWait, nextAction])
        
        if winOrLose == false{
            UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") - 70, forKey: "Currentscore")
            UserDefaults.standard.synchronize()
            self.run(scoreLoseSequence)
        }
        else if winOrLose == true {
            UserDefaults.standard.set(UserDefaults().integer(forKey: "Currentscore") + 120, forKey: "Currentscore")
            UserDefaults.standard.synchronize()
            if livesForEarth == 2 {
                fire1.isHidden = false
            }
            if livesForEarth == 1 {
                fire1.isHidden = false
                fire2.isHidden = false
            }
            self.run(scoreWinSequence)
        }
    }
    
    func nextActionAfterWait(){
        let generateNewScene = SKAction.run({
            self.generateRandomScene()
        })
        if (countChecker % 3 == 0) && (countChecker >= 3){
                print("Speed Up will load")
                self.currentScoreText.isHidden = true
                self.currentScoreLabel.isHidden = true
                self.earth1.isHidden = true
                self.earth2.isHidden = true
                self.earth3.isHidden = true
                self.speedUpText.isHidden = false
                let hideSpeedUpText = SKAction.run ({
                    self.speedUpText.isHidden = true
                    self.speedUpText.removeAllActions()
                })
                let speedUpSequence = SKAction.sequence([animateSpeedUp, hideSpeedUpText, generateNewScene])
                self.run(speedUpSequence)
    
        }
        else {
            let generateSequence = SKAction.sequence([longWait, generateNewScene])
            self.run(generateSequence)
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
            print("Could not get GameOverSkview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"GameOverScene") else {
            print("Could not make GameOverScene")
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
        else if randomNumber > 80 && randomNumber <= 90{
            randomNumberSecond = 5
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        else if randomNumber > 90 && randomNumber <= 100 {
            randomNumberSecond = 6
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        //print(randomNumberSecond)
        print(UserDefaults().integer(forKey: "Randomnumbersecond"))
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
                scene.scaleMode = .aspectFit
                
                /* Show debug */
                skView.showsPhysics = false
                skView.showsDrawCount = false
                skView.showsFPS = false
                
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
                scene.scaleMode = .aspectFit
                
                /* Show debug */
                skView.showsPhysics = false
                skView.showsDrawCount = false
                skView.showsFPS = false
                
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
                scene.scaleMode = .aspectFit
                
                /* Show debug */
                skView.showsPhysics = false
                skView.showsDrawCount = false
                skView.showsFPS = false
                
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
                scene.scaleMode = .aspectFit
                
                /* Show debug */
                skView.showsPhysics = false
                skView.showsDrawCount = false
                skView.showsFPS = false
                
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
                    print("Could not make AirPollution")
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
            else if randomNumberSecond == 6{
                /* 1) Grab reference to our SpriteKit view */
                guard let skView = self.view as SKView! else {
                    print("Could not get Skview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"OzoneScene") else {
                    print("Could not make OzoneScene")
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
