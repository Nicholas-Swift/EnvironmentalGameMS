//
//  GameState.swift
//  EnvironmentalGame
//
//  Created by Nick Swift on 8/19/17.
//  Copyright © 2017 Havi Nguyen. All rights reserved.
//

import Foundation

class GameState {
    
    // MARK: - Instance Variables
    static var currentScore: Int = 0
    
    // NOTE TO HAVI:
    // Take a look at this GameState class.
    
    // You should add many variables to keep track of the state of your game.
    // These will all be held in memory while the game is running.
    
    // If you want to save something to be held throughout all games (example: high score)
    // THEN you should save to user defaults.
    
    // Otherwise just make a variable here.
    // This is an example of a singleton - an instance that can be accessed by any file
    // There are some issues with singletons such as issues with thread safety
    // These can be fixed with dispatch queues and barrier tasks, but you will likely not run into any issues
    
    // I've already changed all currentScores to use this singleton class, as you'll see in the pull request
    // I would recommend you switch all your other variables that you're holding in user defaults to this as well
    // (NOT things you want to sync throughout all games though)
    
    // This will likely fix a lot of bugs you are having. Good luck!
    
    
}
