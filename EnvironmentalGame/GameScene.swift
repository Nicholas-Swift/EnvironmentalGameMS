//
//  GameScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/10/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import Foundation
class GameScene: SKScene {
    
    var playButton: MSButtonNode!
    var countChecker : Int = 0 // needs to be in userdefault
    var randomNumberFirst: Int = 0
    var randomNumberSecond: Int = 0
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
    
       override func didMove(to view: SKView) {
        playButton = childNode(withName: "playButton") as! MSButtonNode
        playButton.selectedHandler = {
            self.generateRandomScene()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    public func generateRandomScene() {
        let randomNumber = arc4random_uniform(100)
        if randomNumber <= 100/3{
        randomNumberSecond = 1
            loadRandomScene()
        }
        else if randomNumber <= (100/3) * 2 {
        randomNumberSecond = 2
            loadRandomScene()
        }
        else if randomNumber <= (100) && randomNumber > ((100/3) * 2) {
        randomNumberSecond = 3
            loadRandomScene()
        }
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
                guard let scene = GameScene(fileNamed:"BirdMiniScene") else {
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
                guard let scene = GameScene(fileNamed:"OverfishingScene") else {
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
                guard let scene = GameScene(fileNamed:"IceMeltingScene") else {
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
    }
}
