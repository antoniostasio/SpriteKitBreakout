//
//  Model.swift
//  breakout
//
//  Created by Ignazio Finizio on 20/02/2017.
//  Copyright © 2017 Ignazio Finizio. All rights reserved.
//

import SpriteKit

enum BodyType:UInt32 {
    case ball = 3
    case brick = 5
    case paddle = 9
    case borders = 17
    case bottom = 33
    case noCollisions = 64
}
let maxBallsNumber = 5

let brickColors = [SKColor.red,SKColor.blue,SKColor.green,SKColor.yellow,SKColor.white,SKColor.cyan,SKColor.orange]
let numRows = 6
let numColumns = 20
let maxBricksNumber = numRows * numColumns
