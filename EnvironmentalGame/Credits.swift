//
//  Credits.swift
//  EnvironmentalGame
//
//  Created by Havi Nguyen on 8/8/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import SpriteKit

class Credits: SKScene {
    
    var mainMenuButton: MSButtonNode!
    
    override func didMove(to view: SKView) {
        mainMenuButton = childNode(withName: "mainMenuButton") as! MSButtonNode
        mainMenuButton.selectedHandler = {
            self.loadMainMenu()
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
        scene.scaleMode = .aspectFit
        
        /* Show debug */
        skView.showsPhysics = false
        skView.showsDrawCount = false
        skView.showsFPS = false
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
