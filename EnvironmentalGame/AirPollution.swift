//
//  AirPollution.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/18/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import AVFoundation

class AirPollution: SKScene{
    
    var audioPlayer = AVAudioPlayer()
    var factory1: SKSpriteNode!
    var factory2: SKSpriteNode!
    var factory3: SKSpriteNode!
    var factory4: SKSpriteNode!
    var factory5: SKSpriteNode!
    var smoke1: SKEmitterNode!
    var smoke2: SKEmitterNode!
    var smoke3: SKEmitterNode!
    var smoke4: SKEmitterNode!
    var smoke5: SKEmitterNode!
    var airMainLabel: SKLabelNode!
    var airLabel: SKLabelNode!
    var airLabel2: SKLabelNode!
    var touchLocation = CGPoint.zero
    var timeBar: SKSpriteNode!
    let randomNumber = arc4random_uniform(100)
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
    /*override func sceneDidLoad() {
        super.sceneDidLoad()
        
        print("Scene loaded")
    }*/
    
    let smokeStop = SKAction(named: "SmokeStop")!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        print("Airpollution \(countChecker) count checker")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hustle", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error in loading Air Pollution Scene Background music")
        }
        
        audioPlayer.play()
        factory1 = childNode(withName: "factory1") as! SKSpriteNode
        factory2 = childNode(withName: "factory2") as! SKSpriteNode
        factory3 = childNode(withName: "factory3") as! SKSpriteNode
        factory4 = childNode(withName: "factory4") as! SKSpriteNode
        factory5 = childNode(withName: "factory5") as! SKSpriteNode
        smoke1 = factory1.childNode(withName: "smoke1") as! SKEmitterNode
        smoke2 = factory2.childNode(withName: "smoke2") as! SKEmitterNode
        smoke3 = factory3.childNode(withName: "smoke3") as! SKEmitterNode
        smoke4 = factory4.childNode(withName: "smoke4") as! SKEmitterNode
        smoke5 = factory5.childNode(withName: "smoke5") as! SKEmitterNode
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        airMainLabel = self.childNode(withName: "airMainLabel") as! SKLabelNode
        airLabel = self.childNode(withName: "airLabel") as! SKLabelNode
        airLabel2 = self.childNode(withName: "airLabel2") as! SKLabelNode
        generateRandomFactory()
       
    }
    func generateRandomFactory(){
        
        if randomNumber <= 10{
           factory4.isHidden = true
            smoke4.isHidden = true
            factory5.isHidden = true
            smoke5.isHidden = true
        }
        else if randomNumber <= 20 && randomNumber > 10 {
            factory2.isHidden = true
            smoke2.isHidden = true
            factory5.isHidden = true
            smoke5.isHidden = true
        }
        else if randomNumber <= 30 && randomNumber > 20 {
            factory2.isHidden = true
            smoke2.isHidden = true
            factory4.isHidden = true
            smoke4.isHidden = true
        }
        else if randomNumber <= 40 && randomNumber > 30 {
            factory1.isHidden = true
            smoke1.isHidden = true
            factory3.isHidden = true
            smoke3.isHidden = true
            
        }
        else if randomNumber <= 50 && randomNumber > 40 {
            factory3.isHidden = true
            smoke3.isHidden = true
            factory5.isHidden = true
            smoke5.isHidden = true
        }
        else if randomNumber <= 60 && randomNumber > 50 {
            factory1.isHidden = true
            smoke1.isHidden = true
            factory4.isHidden = true
            smoke4.isHidden = true
            
        }
        else if randomNumber <= 70 && randomNumber > 60 {
            factory4.isHidden = true
            smoke4.isHidden = true
        }
        else if randomNumber <= 80 && randomNumber > 70 {
            factory5.isHidden = true
            smoke5.isHidden = true
        }
        else if randomNumber <= 90 && randomNumber > 80 {
            factory2.isHidden = true
            smoke2.isHidden = true
        }
        else if randomNumber <= 100 && randomNumber > 90 {
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches{
            touchLocation = touch.location(in: self)
            if factory1.contains(touchLocation) && smoke1.isHidden == false {
                smoke1.isHidden = true
                print("fml")
                factory1.run(smokeStop)
            }
            else if factory2.contains(touchLocation) && smoke2.isHidden == false{
                smoke2.isHidden = true
                print("fml2")
                factory2.run(smokeStop)
            }
            else if factory3.contains(touchLocation) && smoke3.isHidden == false{
                smoke3.isHidden = true
                print("fml3")
                factory3.run(smokeStop)
            }
            else if factory4.contains(touchLocation) && smoke4.isHidden == false{
                smoke4.isHidden = true
                print("fml4")
                factory4.run(smokeStop)
            }
            else if factory5.contains(touchLocation) && smoke5.isHidden == false{
                smoke5.isHidden = true
                print("fml5")
                factory5.run(smokeStop)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            let wait = SKAction.wait(forDuration: 0.5)
            let failedAirGame = SKAction.run({
                self.failedGame()
            })
            let failedSequence = SKAction.sequence([wait, failedAirGame])
        
        for touch in touches{
            touchLocation = touch.location(in: self)
            if !(factory1.contains(touchLocation)) {
                smoke1.isHidden = false
                self.run(failedSequence)
            }
            if !(factory2.contains(touchLocation)) {
                smoke2.isHidden = false
                self.run(failedSequence)
            }
            if !(factory3.contains(touchLocation)) {
                smoke3.isHidden = false
                self.run(failedSequence)
            }
            if !(factory4.contains(touchLocation)) {
                smoke4.isHidden = false
                self.run(failedSequence)
            }
            if !(factory5.contains(touchLocation)) {
                smoke5.isHidden = false
                self.run(failedSequence)
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
        else if countChecker <= 39 && countChecker > 36{
            time -= 0.0095
        }
        if time <= 0.8 {
            airMainLabel.isHidden = true
            airLabel.isHidden = true
            airLabel2.isHidden = true
        }
        
        //Player ran out of time
        if time < 0 {
            if smoke1.isHidden == true && smoke2.isHidden == true && smoke3.isHidden == true && smoke4.isHidden == true && smoke5.isHidden == true {
                completeGame()
            }
            else {
                failedGame()
            }
        }
    }
    func completeGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(true, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
        print("AirPollutionScene \(UserDefaults().bool(forKey: "Winorlose")) ")
        loadScoreScreen()
    }
    func failedGame(){
        audioPlayer.stop()
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
