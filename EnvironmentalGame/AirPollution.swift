//
//  AirPollution.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/18/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import Foundation

import SpriteKit

class AirPollution: SKScene{
    
    var factory1: SKSpriteNode!
    var factory2: SKSpriteNode!
    var factory3: SKSpriteNode!
    var factory4: SKSpriteNode!
    var factory5: SKSpriteNode!
    var factory6: SKSpriteNode!
    var factory7: SKSpriteNode!
    var factory8: SKSpriteNode!
    var smoke1: SKEmitterNode!
    var smoke2: SKEmitterNode!
    var smoke3: SKEmitterNode!
    var smoke4: SKEmitterNode!
    var smoke5: SKEmitterNode!
    var smoke6: SKEmitterNode!
    var smoke7: SKEmitterNode!
    var smoke8: SKEmitterNode!
    var airMainLabel: SKLabelNode!
    var airLabel: SKLabelNode!
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
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        print("Scene loaded")
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        factory1 = childNode(withName: "factory1") as! SKSpriteNode
        factory2 = childNode(withName: "factory2") as! SKSpriteNode
        factory3 = childNode(withName: "factory3") as! SKSpriteNode
        factory4 = childNode(withName: "factory4") as! SKSpriteNode
        factory5 = childNode(withName: "factory5") as! SKSpriteNode
        factory6 = childNode(withName: "factory6") as! SKSpriteNode
        factory7 = childNode(withName: "factory7") as! SKSpriteNode
        factory8 = childNode(withName: "factory8") as! SKSpriteNode
        smoke1 = factory1.childNode(withName: "smoke1") as! SKEmitterNode
        smoke2 = factory2.childNode(withName: "smoke2") as! SKEmitterNode
        smoke3 = factory3.childNode(withName: "smoke3") as! SKEmitterNode
        smoke4 = factory4.childNode(withName: "smoke4") as! SKEmitterNode
        smoke5 = factory5.childNode(withName: "smoke5") as! SKEmitterNode
        smoke6 = factory6.childNode(withName: "smoke6") as! SKEmitterNode
        smoke7 = factory7.childNode(withName: "smoke7") as! SKEmitterNode
        smoke8 = factory8.childNode(withName: "smoke8") as! SKEmitterNode
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        airMainLabel = self.childNode(withName: "airMainLabel") as! SKLabelNode
        airLabel = self.childNode(withName: "airLabel") as! SKLabelNode
        if countChecker <= 6{
        generateRandomFactoryEasy()
        }
        else {
        generateRandomFactoryHard()
        }
    }
    func generateRandomFactoryEasy(){
        
        if randomNumber <= 10{
            factory2.isHidden = true
            factory3.isHidden = true
            factory4.isHidden = true
            factory5.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 20 && randomNumber > 10 {
            factory1.isHidden = true
            factory3.isHidden = true
            factory4.isHidden = true
            factory6.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 30 && randomNumber > 20 {
            factory3.isHidden = true
            factory4.isHidden = true
            factory6.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 40 && randomNumber > 30 {
            factory2.isHidden = true
            factory4.isHidden = true
            factory5.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 50 && randomNumber > 40 {
            factory1.isHidden = true
            factory4.isHidden = true
            factory5.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 60 && randomNumber > 50 {
            factory1.isHidden = true
            factory4.isHidden = true
            factory6.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 70 && randomNumber > 60 {
            factory1.isHidden = true
            factory5.isHidden = true
            factory6.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 80 && randomNumber > 70 {
            factory2.isHidden = true
            factory3.isHidden = true
            factory6.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 90 && randomNumber > 80 {
            factory2.isHidden = true
            factory3.isHidden = true
            factory5.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 100 && randomNumber > 90 {
            factory1.isHidden = true
            factory2.isHidden = true
            factory5.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        
    }
    func generateRandomFactoryHard(){
        
        if randomNumber <= 10{
            factory3.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 20 && randomNumber > 10 {
            factory3.isHidden = true
            factory4.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 30 && randomNumber > 20 {
            factory1.isHidden = true
            factory5.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 40 && randomNumber > 30 {
            factory1.isHidden = true
            factory6.isHidden = true
            factory7.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 50 && randomNumber > 40 {
            factory2.isHidden = true
            factory3.isHidden = true
            factory5.isHidden = true
            factory8.isHidden = true
        }
        else if randomNumber <= 60 && randomNumber > 50 {
            factory2.isHidden = true
            factory4.isHidden = true
            factory5.isHidden = true
            factory6.isHidden = true
        }
        else if randomNumber <= 70 && randomNumber > 60 {
            factory1.isHidden = true
            factory3.isHidden = true
            factory5.isHidden = true
        }
        else if randomNumber <= 80 && randomNumber > 70 {
            factory5.isHidden = true
            factory6.isHidden = true
            factory7.isHidden = true
        }
        else if randomNumber <= 90 && randomNumber > 80 {
        }
        else if randomNumber <= 100 && randomNumber > 90 {
            factory3.isHidden = true
            factory4.isHidden = true
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        airMainLabel.isHidden = true
        airLabel.isHidden = true
        for touch in touches{
            touchLocation = touch.location(in: self)
            if factory1.contains(touchLocation){
                smoke1.isHidden = true
                print("fml")
            }
            else if factory2.contains(touchLocation){
                smoke2.isHidden = true
                print("fml2")
            }
            else if factory3.contains(touchLocation){
                smoke3.isHidden = true
                print("fml3")
            }
            else if factory4.contains(touchLocation){
                smoke4.isHidden = true
                print("fml4")
            }
            else if factory5.contains(touchLocation){
                smoke5.isHidden = true
                print("fml5")
            }
            else if factory6.contains(touchLocation){
                smoke6.isHidden = true
                print("fml6")
            }
            else if factory7.contains(touchLocation){
                smoke7.isHidden = true
                print("fml7")
            }
            else if factory8.contains(touchLocation){
                smoke8.isHidden = true
                print("fml8")
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.location(in: self)
            
                smoke1.isHidden = false
            
                smoke2.isHidden = false
            
                smoke3.isHidden = false
            
                smoke4.isHidden = false
            
                smoke5.isHidden = false
            
                smoke6.isHidden = false
            
                smoke7.isHidden = false
            
                smoke8.isHidden = false
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
        //Player ran out of time
        if time < 0 {
            if smoke1.isHidden == true || smoke2.isHidden == true || smoke3.isHidden == true || smoke4.isHidden == true || smoke5.isHidden == true || smoke6.isHidden == true || smoke7.isHidden == true || smoke8.isHidden == true {
                completeGame()
            }
            else{
            failedGame()
            }
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
        print(UserDefaults().integer(forKey: "Numberoflives"))
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
