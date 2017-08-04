//
//  StartScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/10/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import Foundation
class StartScene: SKScene {
    
    var playButton: MSButtonNode!
    // var countChecker : Int = 0 // needs to be in userdefault
    // var randomNumberFirst: Int = 0
    // var randomNumberSecond: Int = 0
    var highScore: Int {
        get {
            if let storedHighScore = UserDefaults.standard.object(forKey: "Highscore") as? Int {
                return storedHighScore
            }
            return 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Highscore")
            UserDefaults.standard.synchronize()
        }
    }
    var currentScore: Int {
        get {
            if let storedCurrentScore = UserDefaults.standard.object(forKey: "Currentscore") as? Int {
                return storedCurrentScore
            }
            return 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Currentscore")
            UserDefaults.standard.synchronize()
        }
    }
    var countChecker: Int {
        get {
            if let storedCountChecker = UserDefaults.standard.object(forKey: "Countchecker") as? Int {
                return storedCountChecker
            }
            return 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Countchecker")
            UserDefaults.standard.synchronize()
        }
    }
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
    
    var numberOfLives: Int {
        get {
            if let storednumberOfLives = UserDefaults.standard.object(forKey: "Numberoflives") as? Int {
                return storednumberOfLives
            }
            return 0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Numberoflives")
            UserDefaults.standard.set(3, forKey: "Numberoflives")
            UserDefaults.standard.synchronize()
        }
    }
    override func didMove(to view: SKView) {
        playButton = childNode(withName: "playButton") as! MSButtonNode
        playButton.selectedHandler = {
            self.generateRandomScene()
            UserDefaults.standard.set(0, forKey: "Currentscore")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.set(3, forKey: "Numberoflives")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.set(0, forKey: "Countchecker")
            UserDefaults.standard.synchronize()
            //print(UserDefaults.standard.integer(forKey: "Countchecker"))
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
}
