//
//  OzoneScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 8/8/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import AVFoundation

class OzoneScene: SKScene{
    
    var audioPlayer = AVAudioPlayer()
    var countChecker: Int = 0
    var ozoneMainLabel: SKLabelNode!
    var ozoneLabel: SKLabelNode!
    var cfc1: SKSpriteNode!
    var cfc2: SKSpriteNode!
    var cfc3: SKSpriteNode!
    var cfc4: SKSpriteNode!
    var cfc5: SKSpriteNode!
    var cfc6: SKSpriteNode!
    var cfc7: SKSpriteNode!
    var cfc8: SKSpriteNode!
    var cfc9: SKSpriteNode!
    var cfc10: SKSpriteNode!
    var oxygen1: SKSpriteNode!
    var oxygen2: SKSpriteNode!
    var oxygen3: SKSpriteNode!
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
        
    let cfcGone = SKAction(named: "CFCGone")!
    
    override func didMove(to view: SKView) {
        
        countChecker = UserDefaults.standard.integer(forKey: "Countchecker")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hustle", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error in loading Ozone Scene Background music")
        }
        
        audioPlayer.play()
        cfc1 = childNode(withName: "cfc1") as! SKSpriteNode
         cfc2 = childNode(withName: "cfc2") as! SKSpriteNode
         cfc3 = childNode(withName: "cfc3") as! SKSpriteNode
         cfc4 = childNode(withName: "cfc4") as! SKSpriteNode
        cfc5 = childNode(withName: "cfc5") as! SKSpriteNode
         cfc6 = childNode(withName: "cfc6") as! SKSpriteNode
         cfc7 = childNode(withName: "cfc7") as! SKSpriteNode
         cfc8 = childNode(withName: "cfc8") as! SKSpriteNode
         cfc9 = childNode(withName: "cfc9") as! SKSpriteNode
        cfc10 = childNode(withName: "cfc10") as! SKSpriteNode
        oxygen1 = childNode(withName: "oxygen1") as! SKSpriteNode
        oxygen2 = childNode(withName: "oxygen2") as! SKSpriteNode
        oxygen3 = childNode(withName: "oxygen3") as! SKSpriteNode
        ozoneMainLabel = childNode(withName: "ozoneMainLabel") as! SKLabelNode
        ozoneLabel = childNode(withName: "ozoneLabel") as! SKLabelNode
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        
        if countChecker < 6 {
            generateRandomCFCEasy()
        }
        else if countChecker >= 6{
            generateRandomCFCHard()
        }
    }
    
    func generateRandomCFCEasy(){
        let randomNumber = arc4random_uniform(100)
        
        if randomNumber <= 20 {
            cfc2.isHidden = true
            cfc6.isHidden = true
            cfc7.isHidden = true
            cfc8.isHidden = true
            cfc9.isHidden = true
        }
        else if randomNumber <= 40 && randomNumber > 20 {
            cfc1.isHidden = true
            cfc4.isHidden = true
            cfc7.isHidden = true
            cfc8.isHidden = true
            cfc10.isHidden = true
           
        }
        else if randomNumber <= 60 && randomNumber > 40 {
            cfc1.isHidden = true
            cfc3.isHidden = true
            cfc6.isHidden = true
            cfc8.isHidden = true
        }
        
        else if randomNumber <= 80 && randomNumber > 60 {
            cfc1.isHidden = true
            cfc5.isHidden = true
            cfc7.isHidden = true
            cfc10.isHidden = true
        }
        else if randomNumber <= 100 && randomNumber > 80 {
            cfc1.isHidden = true
            cfc2.isHidden = true
            cfc5.isHidden = true
            cfc10.isHidden = true
        }
    
    }
    
    func generateRandomCFCHard(){
        
        let randomNumber = arc4random_uniform(100)
        
        if randomNumber <= 20 {
            cfc1.isHidden = true
            cfc5.isHidden = true
            cfc9.isHidden = true
        }
        else if randomNumber <= 40 && randomNumber > 20 {
            cfc1.isHidden = true
            cfc10.isHidden = true
            
        }
        else if randomNumber <= 60 && randomNumber > 40 {
            cfc3.isHidden = true

        }
            
        else if randomNumber <= 80 && randomNumber > 60 {
            cfc1.isHidden = true
            cfc7.isHidden = true
        }
        else if randomNumber <= 100 && randomNumber > 80 {
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.location(in: self)
            
            if cfc1.contains(touchLocation){
                cfc1.run(cfcGone)
                cfc1.isHidden = true
            }
            else if cfc2.contains(touchLocation){
                cfc2.run(cfcGone)
                cfc2.isHidden = true
            }
            else if cfc3.contains(touchLocation){
                cfc3.run(cfcGone)
                cfc3.isHidden = true
            }
            else if cfc4.contains(touchLocation){
                cfc4.run(cfcGone)
                cfc4.isHidden = true
            }
            else if cfc5.contains(touchLocation){
                cfc5.run(cfcGone)
                cfc5.isHidden = true
            }
            else if cfc6.contains(touchLocation){
                cfc6.run(cfcGone)
                cfc6.isHidden = true
            }
            else if cfc7.contains(touchLocation){
                cfc7.run(cfcGone)
                cfc7.isHidden = true
            }
            else if cfc8.contains(touchLocation){
                cfc8.run(cfcGone)
                cfc8.isHidden = true
            }
            else if cfc9.contains(touchLocation){
                cfc9.run(cfcGone)
                cfc9.isHidden = true
            }
            else if cfc10.contains(touchLocation){
                cfc10.run(cfcGone)
                cfc10.isHidden = true
            }
        }
        }
     override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if countChecker <= 3{
            time -= 0.0017
        }
        else if countChecker <= 6 && countChecker > 3 {
            time -= 0.0022
        }
        else if countChecker <= 9 && countChecker > 6 {
            time -= 0.003
        }
        else if countChecker <= 12 && countChecker > 9 {
            time -= 0.004
        }
        else if countChecker <= 15 && countChecker > 12 {
            time -= 0.006
        }
        else if countChecker <= 18 && countChecker > 15 {
            time -= 0.0065
        }
        else if countChecker <= 21 && countChecker > 18 {
            time -= 0.007
        }
        else if countChecker <= 24 && countChecker > 21 {
            time -= 0.0075
        }
        else if countChecker <= 27 && countChecker > 24 {
            time -= 0.008
        }
        else if countChecker <= 30 && countChecker > 27 {
            time -= 0.0085
        }
        else if countChecker <= 33 && countChecker > 27 {
            time -= 0.009
        }
        else if countChecker <= 36 && countChecker > 33 {
            time -= 0.0093
        }
        else if countChecker <= 39 && countChecker > 36 {
            time -= 0.0095
        }
        
        if cfc1.isHidden == true && cfc2.isHidden == true && cfc3.isHidden == true && cfc4.isHidden == true && cfc5.isHidden == true && cfc6.isHidden == true && cfc7.isHidden == true && cfc8.isHidden == true && cfc9.isHidden == true && cfc10.isHidden == true {
            completeGame()
        }
        if time <= 0.7 {
            ozoneMainLabel.isHidden = true
            ozoneLabel.isHidden = true
        }
        //Player ran out of time
        if time < 0 {
            let wait = SKAction.wait(forDuration: 1.0)
            let changeOxygen = SKAction.run ({
                self.audioPlayer.stop()
                self.oxygen1.texture = SKTexture(imageNamed: "OxygenSad")
                self.oxygen2.texture = SKTexture(imageNamed: "OxygenSad")
                self.oxygen3.texture = SKTexture(imageNamed: "OxygenSad")
            })
            let failedOzoneGame = SKAction.run({
                self.failedGame()
            })
        let failedSequence = SKAction.sequence([changeOxygen, wait, failedOzoneGame])
        oxygen1.run(failedSequence)
        }
    }
        
    func completeGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(true, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
        print("OzoneScene \(UserDefaults().bool(forKey: "Winorlose")) ")
        loadScoreScreen()
    }
        
    func failedGame(){
        UserDefaults.standard.set(false, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
        print("BirdMiniScene \(UserDefaults().bool(forKey: "Winorlose")) ")
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Numberoflives") - 1, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        print("AirPollution \(UserDefaults().integer(forKey: "Numberoflives")) number of lives")
        loadScoreScreen()
        
    }
    
    func loadScoreScreen(){
        
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView! else {
            print("Could not get ScoreSkview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = SKScene(fileNamed:"ScoreScene") else {
            print("Could not make ScoreScene")
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
