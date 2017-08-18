//
//  OverfishingScene.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 7/12/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit
import AVFoundation

/*enum OverfishingSceneState {
    case active, notActive
}*/

class OverfishingScene: SKScene, SKPhysicsContactDelegate {
    
    var audioPlayer = AVAudioPlayer()
    var fish: SKSpriteNode!
    var fishState: Bool = true
    var fishPosition = CGPoint.zero
    var net: SKSpriteNode!
    var netPosition = CGPoint.zero
    var timeBar: SKSpriteNode!
    var overfishingMainLabel: SKLabelNode!
    var overfishingLabel: SKLabelNode!
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
    
    let fishSwim = SKAction(named: "FishSwim")!
    let fishDead = SKAction(named: "FishDeadAction")!
    let netMove = SKAction(named: "NetMove")!
    
    //Game management
    //var gameState: OverfishingSceneState = .active
    
    override func didMove(to view: SKView) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hustle", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error in loading Start Scene Background music")
        }
        
        audioPlayer.play()
        
        /* Setup your scene here */
        fish = self.childNode(withName: "fish") as! SKSpriteNode
        net = self.childNode(withName: "net") as! SKSpriteNode
        
        overfishingMainLabel = self.childNode(withName: "overfishingMainLabel") as! SKLabelNode
        overfishingLabel = self.childNode(withName: "overfishingLabel") as! SKLabelNode
        
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        timeBar = childNode(withName: "timeBar") as! SKSpriteNode
        print("Overfishing \(countChecker) countchecker")
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        fish.physicsBody?.velocity = CGVector(dx: 90, dy: 0)
        let holdDown = UILongPressGestureRecognizer(target: self, action: #selector(stopFish))
        holdDown.minimumPressDuration = 0.2
        view?.addGestureRecognizer(holdDown)
        for touch in touches {
            if touch.force >= 1.5 {
                fish.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
        }
    }
    func stopFish(){
        fish.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if fishState == false {return}
        fish.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        fish.run(fishSwim)
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if fishState == false { return }

        if countChecker <= 3{
            time -= 0.001
            net.physicsBody?.velocity = CGVector(dx: 45, dy: 0)
        }
        else if countChecker <= 6 && countChecker > 3 {
            time -= 0.0014
            net.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
        }
        else if countChecker <= 9 && countChecker > 6 {
            time -= 0.0017
            net.physicsBody?.velocity = CGVector(dx: 60, dy: 0)
        }
        else if countChecker <= 12 && countChecker > 9 {
            time -= 0.0022
            net.physicsBody?.velocity = CGVector(dx: 70, dy: 0)
        }
        else if countChecker <= 15 && countChecker > 12 {
            time -= 0.003
            net.physicsBody?.velocity = CGVector(dx: 80, dy:0)
        }
        else {
            time -= 0.003
            net.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        }
        
        if time <= 0.9 {
            overfishingMainLabel.isHidden = true
            overfishingLabel.isHidden = true
        }
        
        //Player ran out of time
        if time < 0 {
            completeGame()
        }
        fishPosition = fish.position
        if fishPosition.x > 315 {
            completeGame()
        }
        netPosition = net.position
        if netPosition.x > 255{
            net.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        
    }
    
    // Called whenever collision take place
    func didBegin(_ contact: SKPhysicsContact) {
        fish.physicsBody?.isDynamic = false
        let netTemp : SKPhysicsBody = (net.physicsBody)!
        net!.physicsBody = nil
        net.position.x = fishPosition.x
        net.physicsBody? = netTemp
        fishState = false
        print("Fish has died")
        let fishFailedGame = SKAction.run({
            self.failedGame()
        })
        audioPlayer.stop()
        let fishDeadSequence = SKAction.sequence([fishDead, fishFailedGame])
        fish.run(fishDeadSequence)
    }
    func completeGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(true, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
        print("OverfishingScene \(UserDefaults().bool(forKey: "Winorlose")) ")
        loadScoreScreen()
    }
    func failedGame(){
        audioPlayer.stop()
        UserDefaults.standard.set(false, forKey: "Winorlose")
        UserDefaults.standard.synchronize()
        print("OverfishingScene \(UserDefaults().bool(forKey: "Winorlose")) ")
        UserDefaults.standard.set(UserDefaults().integer(forKey: "Numberoflives") - 1, forKey: "Numberoflives")
        UserDefaults.standard.synchronize()
        print("Overfishing \( UserDefaults().integer(forKey: "Numberoflives")) number of lives")
        loadScoreScreen()
        
    }
    func loadScoreScreen(){
        
        // 1) Grab reference to our SpriteKit view
        guard let skView = self.view as SKView! else {
            print("Could not get ScoreSkview from Cverfishing")
            return
        }
        
        // 2) Load Game scene
        guard let scene = SKScene(fileNamed:"ScoreScene") else {
            print("Could not make ScoreScene from Cverfishing")
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
    
}
