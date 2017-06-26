//
//  Utility.swift
//  breakout
//
//  Created by Ignazio Finizio on 20/02/2017.
//  Copyright © 2017 Ignazio Finizio. All rights reserved.
//

import SpriteKit

func soundAction(fileName: String, waitForCompletion: Bool, count: Int)->SKAction{
    return SKAction.repeat(SKAction.playSoundFileNamed(fileName, waitForCompletion: waitForCompletion), count: count)
}
