//
//  StartScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/10/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation

class StartScene: SKScene {
  
    // MARK: - Instance Vars
    var audioPlayer = AVAudioPlayer()
    static var openAppOnce: Bool = true
  
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
    
    var winOrLose: Bool {
      get {
        if let storedWinOrLose = UserDefaults.standard.object(forKey: "Winorlose") as? Bool {
          return storedWinOrLose
        }
        return false
      }
      set {
        UserDefaults.standard.set(newValue, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
      }
    }
  
    // MARK: - SKNodes
    var title: SKLabelNode!
    var playButton: MSButtonNode!
    var saveEarthButton: MSButtonNode!
    var happyEarth: SKSpriteNode!
  
    // MARK: - SKActions
    let animateHappyEarth = SKAction(named: "AnimateHappyEarth")!
    let wait = SKAction.wait(forDuration: 0.7)
    let fadeOut = SKAction.fadeOut(withDuration: 0.5)
  
    // MARK: - Scene Lifecycle
    override func didMove(to view: SKView) {
      
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Marchofthespoons", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error in loading Start Scene Background music")
        }
        
        UserDefaults.standard.set(0, forKey: "Currentscore")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(3, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(0, forKey: "Countchecker")
        UserDefaults.standard.synchronize()
        
        print("StartScene \(UserDefaults.standard.integer(forKey: "Currentscore")) current score")
        print("StartScene \(UserDefaults.standard.integer(forKey: "Numberoflives")) number of lives")
        print("StartScene \(UserDefaults.standard.integer(forKey: "Countchecker")) count checker")
        
        playButton = childNode(withName: "playButton") as! MSButtonNode
        playButton.selectedHandler = { [weak self] in
            self?.generateRandomScene()
            self?.audioPlayer.stop()
        }
        
        saveEarthButton = childNode(withName: "saveEarthButton") as! MSButtonNode
        saveEarthButton.selectedHandler = { [weak self] in
            self?.loadSaveEarth()
            self?.audioPlayer.stop()
        }
        
        playButton.isHidden = true
        saveEarthButton.isHidden = true
        
        title = childNode(withName: "title") as! SKLabelNode
        title.isHidden = true
      
        let lastSectionAnimation = SKAction.run ({
            self.happyEarth.texture = SKTexture(imageNamed: "BruisedEarth")
        })
        let revealStartScene = SKAction.run ({
            self.playButton.isHidden = false
            self.saveEarthButton.isHidden = false
            self.title.isHidden = false
            
        })
        let audioPlay = SKAction.run ({
            self.playBackgroundMusic()
        })
        
        happyEarth = childNode(withName: "happyEarth") as! SKSpriteNode
        
        if StartScene.openAppOnce == false {
            self.playButton.isHidden = false
            self.saveEarthButton.isHidden = false
            self.title.isHidden = false
            happyEarth.isHidden = true
            audioPlayer.play()
        }
        if StartScene.openAppOnce == true {
            let animationEarthSequence = SKAction.sequence([wait, animateHappyEarth, lastSectionAnimation, wait, fadeOut, revealStartScene, audioPlay])
            happyEarth.run(animationEarthSequence)
            StartScene.openAppOnce = false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

// MARK: - Private Methods
extension StartScene {
  
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
      print("StartScene \(UserDefaults().integer(forKey: "Randomnumbersecond")) random 2nd #")
    }
    public func loadRandomScene(){
      if randomNumberSecond != randomNumberFirst{
        if randomNumberSecond == 1 {
          // 1) Grab reference to our SpriteKit view
          guard let skView = self.view as SKView! else {
            print("Could not get BirdMiniSkview")
            return
          }
          
          // 2) Load Game scene
          guard let scene = SKScene(fileNamed:"BirdMiniScene") else {
            print("Could not make BirdMiniScene")
            return
          }
          
          // 3) Ensure correct aspect mode
          scene.scaleMode = .aspectFit
          
          // debug
          skView.showsPhysics = false
          skView.showsDrawCount = false
          skView.showsFPS = false
          
          // 4) Start game scene
          skView.presentScene(scene)
        }
        else if randomNumberSecond == 2 {
          // 1) Grab reference to our SpriteKit view
          guard let skView = self.view as SKView! else {
            print("Could not get OverfishingSkview")
            return
          }
          
          // 2) Load Game scene
          guard let scene = SKScene(fileNamed:"OverfishingScene") else {
            print("Could not make OverfishingScene")
            return
          }
          
          // 3) Ensure correct aspect mode
          scene.scaleMode = .aspectFit
          
          // debug
          skView.showsPhysics = false
          skView.showsDrawCount = false
          skView.showsFPS = false
          
          // 4) Start game scene
          skView.presentScene(scene)
        }
        else if randomNumberSecond == 3{
          // 1) Grab reference to our SpriteKit view
          guard let skView = self.view as SKView! else {
            print("Could not get IceMeltingSkview")
            return
          }
          
          // 2) Load Game scene
          guard let scene = SKScene(fileNamed:"IceMeltingScene") else {
            print("Could not make IceMeltingScene")
            return
          }
          
          // 3) Ensure correct aspect mode
          scene.scaleMode = .aspectFit
          
          // Debug
          skView.showsPhysics = false
          skView.showsDrawCount = false
          skView.showsFPS = false
          
          // 4) Start game scene
          skView.presentScene(scene)
        }
        else if randomNumberSecond == 4{
          // 1) Grab reference to our SpriteKit view
          guard let skView = self.view as SKView! else {
            print("Could not get DeforestationSkview")
            return
          }
          
          // 2) Load Game scene
          guard let scene = SKScene(fileNamed:"DeforestationScene") else {
            print("Could not make DeforestationScene")
            return
          }
          
          // 3) Ensure correct aspect mode
          scene.scaleMode = .aspectFit
          
          // Show debug
          skView.showsPhysics = false
          skView.showsDrawCount = false
          skView.showsFPS = false
          
          // 4) Start game scene
          skView.presentScene(scene)
        }
        else if randomNumberSecond == 5{
          // 1) Grab reference to our SpriteKit view
          guard let skView = self.view as SKView! else {
            print("Could not get AirPollutionSkview")
            return
          }
          
          // 2) Load Game scene
          guard let scene = SKScene(fileNamed:"AirPollution") else {
            print("Could not make AirPollutionScene")
            return
          }
          
          // 3) Ensure correct aspect mode
          scene.scaleMode = .aspectFit
          
          // Show debug
          skView.showsPhysics = false
          skView.showsDrawCount = false
          skView.showsFPS = false
          
          // 4) Start game scene
          skView.presentScene(scene)
        }
        else if randomNumberSecond == 6{
          // 1) Grab reference to our SpriteKit view
          guard let skView = self.view as SKView! else {
            print("Could not get OzoneSkview")
            return
          }
          
          // 2) Load Game scene
          guard let scene = SKScene(fileNamed:"OzoneScene") else {
            print("Could not make AirPollutionScene")
            return
          }
          
          // 3) Ensure correct aspect mode
          scene.scaleMode = .aspectFit
          
          // debug
          skView.showsPhysics = false
          skView.showsDrawCount = false
          skView.showsFPS = false
          
          // 4) Start game scene
          skView.presentScene(scene)
        }
      }
      else{
        generateRandomScene()
      }
      randomNumberFirst = randomNumberSecond
      UserDefaults.standard.set(randomNumberSecond, forKey: "Randomnumberfirst")
      UserDefaults.standard.synchronize()
      print("StartScene \(randomNumberFirst) random 1st #")
    }
    
    func loadSaveEarth(){
      
      // 1) Grab reference to our SpriteKit view
      guard let skView = self.view as SKView! else {
        print("Could not get Skview")
        return
      }
      
      // 2) Load Game scene
      guard let scene = SKScene(fileNamed:"SaveEarth") else {
        print("Could not make GameScene, check the name is spelled correctly")
        return
      }
      
      // 3) Ensure correct aspect mode
      scene.scaleMode = .aspectFit
      
      // Show debug
      skView.showsPhysics = false
      skView.showsDrawCount = false
      skView.showsFPS = false
      
      // 4) Start game scene
      skView.presentScene(scene)
    }
    
    func playBackgroundMusic(){
      audioPlayer.play()
    }
  
}
