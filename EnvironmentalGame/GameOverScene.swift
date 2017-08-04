//
//  GameOverScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/20/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    var scoreGameOverLabel: SKLabelNode!
    var highScoreGameOverLabel: SKLabelNode!
    var earthFact: SKSpriteNode!
    var menuButton: MSButtonNode!
    var saveEarthButton: MSButtonNode!
    var playAgainButton: MSButtonNode!
    var currentScoreGameOver: Int = 0
    var highScoreGameOver: Int = 0
    var randomNumberScene: Int = 0
    let randomNumber = arc4random_uniform(100)
    
    override func didMove(to view: SKView) {
        earthFact = self.childNode(withName: "earthFact") as! SKSpriteNode
        scoreGameOverLabel = childNode(withName: "scoreGameOverLabel") as! SKLabelNode
        highScoreGameOverLabel = childNode(withName: "highScoreGameOverLabel") as! SKLabelNode
        menuButton = childNode(withName: "menuButton") as! MSButtonNode
        menuButton.selectedHandler = {
            self.loadMainMenu()
        }
        playAgainButton = childNode(withName: "playAgainButton") as! MSButtonNode
        playAgainButton.selectedHandler = {
            self.generateRandomNumberForScene()
        }
        saveEarthButton = childNode(withName: "saveEarthButton") as! MSButtonNode
        saveEarthButton.selectedHandler = {
            self.loadSaveEarth()
        }
        currentScoreGameOver = UserDefaults.standard.integer(forKey: "Currentscore")
        highScoreGameOver = UserDefaults.standard.integer(forKey: "Highscore")
        if currentScoreGameOver > highScoreGameOver {
            UserDefaults.standard.set(currentScoreGameOver, forKey: "Highscore")
            UserDefaults.standard.synchronize()
        }
        scoreGameOverLabel.text = String(UserDefaults.standard.integer(forKey: "Currentscore"))
        highScoreGameOverLabel.text = String(UserDefaults.standard.integer(forKey: "Highscore"))
        print(currentScoreGameOver)
        print(highScoreGameOver)
        UserDefaults.standard.set(0, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(3, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(0, forKey: "Countchecker")
        UserDefaults.standard.synchronize()
        generateFact()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func generateFact(){
        if randomNumber <= 10{
            earthFact.texture = SKTexture(imageNamed: "Fact1@1x")
        }
        else if randomNumber <= 20 && randomNumber > 10 {
            earthFact.texture = SKTexture(imageNamed: "Fact2@1x")
        }
        else if randomNumber <= 30 && randomNumber > 20 {
            earthFact.texture = SKTexture(imageNamed: "Fact3@1x")
        }
        else if randomNumber <= 40 && randomNumber > 30 {
            earthFact.texture = SKTexture(imageNamed: "Fact4@1x")
        }
        else if randomNumber <= 50 && randomNumber > 40 {
            earthFact.texture = SKTexture(imageNamed: "Fact5@1x")
        }
        else if randomNumber <= 60 && randomNumber > 50 {
            earthFact.texture = SKTexture(imageNamed: "Fact6@1x")
        }
        else if randomNumber <= 70 && randomNumber > 60 {
            earthFact.texture = SKTexture(imageNamed: "Fact7@1x")
        }
        else if randomNumber <= 80 && randomNumber > 70 {
            earthFact.texture = SKTexture(imageNamed: "Fact8@1x")
        }
        else if randomNumber <= 90 && randomNumber > 80 {
            earthFact.texture = SKTexture(imageNamed: "Fact9@1x")
        }
        else if randomNumber <= 100 && randomNumber > 90 {
            earthFact.texture = SKTexture(imageNamed: "Fact10@1x")
        }
    }
    
    func loadMainMenu(){
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"StartScene") else {
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
    func generateRandomNumberForScene(){
        print("Random \(randomNumber)")
        if randomNumber <= 20{
            randomNumberScene = 1
            loadRandomScene()
        }
        else if randomNumber > 20 && randomNumber <= 40 {
            randomNumberScene = 2
            loadRandomScene()
        }
        else if randomNumber > 40 && randomNumber <= 60 {
            randomNumberScene = 3
            loadRandomScene()
        }
        else if randomNumber > 60 && randomNumber <= 80{
            randomNumberScene = 4
            loadRandomScene()
        }
        else if randomNumber > 80 && randomNumber <= 100{
            randomNumberScene = 5
            loadRandomScene()
        }
    }
    func loadRandomScene(){
        
        print("RandomNumber is \(randomNumberScene)")
        if randomNumberScene == 1 {
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
        else if randomNumberScene == 2 {
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
        else if randomNumberScene == 3{
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
        else if randomNumberScene == 4{
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
        else if randomNumberScene == 5{
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
    func loadSaveEarth(){
        
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"SaveEarth") else {
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
