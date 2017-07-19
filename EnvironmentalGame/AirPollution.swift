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
    var smoke1: SKEmitterNode!
    var smoke2: SKEmitterNode!
    var smoke3: SKEmitterNode!
    var smoke4: SKEmitterNode!
    var touchLocation = CGPoint.zero
    
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
        smoke1 = factory1.childNode(withName: "smoke1") as! SKEmitterNode
        smoke2 = factory2.childNode(withName: "smoke2") as! SKEmitterNode
        smoke3 = factory3.childNode(withName: "smoke3") as! SKEmitterNode
        smoke4 = factory4.childNode(withName: "smoke4") as! SKEmitterNode
        generateRandomFactory()
    }
    func generateRandomFactory(){
        let randomNumber = arc4random_uniform(100)
        print(randomNumber)
        if (randomNumber > 20) && (randomNumber <= 40){
            factory3.isHidden = true
        }
        else if (randomNumber > 40) && (randomNumber <= 60){
            factory1.isHidden = true
        }
        else if (randomNumber > 60) && (randomNumber <= 80) {
            factory2.isHidden = true
            factory3.isHidden = true
        }
        else if (randomNumber > 80) && (randomNumber <= 100) {
            factory4.isHidden = true
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
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
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.location(in: self)
            
                smoke1.isHidden = false
            
                smoke2.isHidden = false
            
                smoke3.isHidden = false
            
                smoke4.isHidden = false
        }
    } 
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
