//
//  GameOverScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/20/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class GameOverScene: SKScene{
    
    var audioPlayer = AVAudioPlayer()
    var scoreGameOverLabel: SKLabelNode!
    var highScoreGameOverLabel: SKLabelNode!
    var earthFact: SKSpriteNode!
    var menuButton: MSButtonNode!
    var saveEarthButton: MSButtonNode!
    var playAgainButton: MSButtonNode!
    var creditsButton: MSButtonNode!
    var currentScoreGameOver: Int = 0
    var highScoreGameOver: Int = 0
    var randomNumberScene: Int = 0
    let randomNumber = arc4random_uniform(100)
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
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Marchofthespoons", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error in loading Start Scene Background music")
        }
        
        audioPlayer.play()
        
        earthFact = self.childNode(withName: "earthFact") as! SKSpriteNode
        scoreGameOverLabel = childNode(withName: "scoreGameOverLabel") as! SKLabelNode
        highScoreGameOverLabel = childNode(withName: "highScoreGameOverLabel") as! SKLabelNode
        menuButton = childNode(withName: "menuButton") as! MSButtonNode
        menuButton.selectedHandler = {
            print(" Open Once game over scene \(UserDefaults.standard.integer(forKey: "OpenOnce")) ")
            self.loadMainMenu()
            self.audioPlayer.stop()
        }
        playAgainButton = childNode(withName: "playAgainButton") as! MSButtonNode
        playAgainButton.selectedHandler = {
            self.generateRandomScene()
            self.audioPlayer.stop()
        }
        saveEarthButton = childNode(withName: "saveEarthButton") as! MSButtonNode
        saveEarthButton.selectedHandler = {
            self.loadSaveEarth()
            self.audioPlayer.stop()
        }
        creditsButton = childNode(withName: "creditsButton") as! MSButtonNode
        creditsButton.selectedHandler = {
            self.loadCredits()
            self.audioPlayer.stop()
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
        else if randomNumber > 90 && randomNumber <= 100{
            randomNumberSecond = 6
            UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumbersecond")
            UserDefaults.standard.synchronize()
            loadRandomScene()
        }
        //print(randomNumberSecond)
        print("GameOverScene \(UserDefaults().integer(forKey: "Randomnumbersecond")) random 2nd #")
    }
    public func loadRandomScene(){
        if randomNumberSecond != randomNumberFirst{
            if randomNumberSecond == 1 {
                /* 1) Grab reference to our SpriteKit view */
                guard let skView = self.view as SKView! else {
                    print("Could not get BirdMiniSkview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"BirdMiniScene") else {
                    print("Could not make BirdMiniScene")
                    return
                }
                
                /* 3) Ensure correct aspect mode */
                scene.scaleMode = .aspectFill
                
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
                    print("Could not get OverfishingSkview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"OverfishingScene") else {
                    print("Could not make OverfishingScene")
                    return
                }
                
                /* 3) Ensure correct aspect mode */
                scene.scaleMode = .aspectFill
                
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
                    print("Could not get IceMeltingSkview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"IceMeltingScene") else {
                    print("Could not make IceMeltingScene")
                    return
                }
                
                /* 3) Ensure correct aspect mode */
                scene.scaleMode = .aspectFill
                
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
                    print("Could not get DeforestationSkview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"DeforestationScene") else {
                    print("Could not make DeforestationScene")
                    return
                }
                
                /* 3) Ensure correct aspect mode */
                scene.scaleMode = .aspectFill
                
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
                    print("Could not get AirPollutionSkview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"AirPollution") else {
                    print("Could not make AirPollutionScene")
                    return
                }
                
                /* 3) Ensure correct aspect mode */
                scene.scaleMode = .aspectFill
                
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
                    print("Could not get OzoneSkview")
                    return
                }
                
                /* 2) Load Game scene */
                guard let scene = SKScene(fileNamed:"OzoneScene") else {
                    print("Could not make OzoneScene")
                    return
                }
                
                /* 3) Ensure correct aspect mode */
                scene.scaleMode = .aspectFill
                
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
        print("GameOverScene \(randomNumberFirst) random 1st #")
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
        skView.showsPhysics = false
        skView.showsDrawCount = false
        skView.showsFPS = false
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    func loadCredits(){
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"Credits") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* Show debug */
        skView.showsPhysics = false
        skView.showsDrawCount = false
        skView.showsFPS = false
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
