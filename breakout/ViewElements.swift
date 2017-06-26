//
//  Elements.swift
//  breakout
//
//  Created by Ignazio Finizio on 20/02/2017.
//  Copyright © 2017 Ignazio Finizio. All rights reserved.
//

import SpriteKit

func drawBorders(scene: SKScene){
    
    let verticalBarSize = CGSize(width: borderBarMin, height: borderBarMid)
    let horizontalBarSize = CGSize(width: borderBarMax, height: borderBarMin)
    
    let leftBar = SKSpriteNode(color: SKColor.blue, size: verticalBarSize)
    leftBar.anchorPoint = CGPoint.zero
    leftBar.position = CGPoint.zero
    leftBar.name = "leftBorder"
    
    let rightBar = SKSpriteNode(color: SKColor.blue, size: verticalBarSize)
    rightBar.anchorPoint = CGPoint.zero
    rightBar.position = CGPoint(x: borderBarRightXPos, y: 0)
    rightBar.name = "rightBorder"
    
    let horizontalBar = SKSpriteNode(color: SKColor.blue, size: horizontalBarSize)
    horizontalBar.anchorPoint = CGPoint.zero
    horizontalBar.position = CGPoint(x: 0, y: borderBarMid)
    horizontalBar.name = "topBorder"
    
    // Physics properties
    leftBar.physicsBody = SKPhysicsBody(rectangleOf: verticalBarSize,
                                        center: CGPoint(x: verticalBarSize.width/2,
                                                        y: verticalBarSize.height/2))
    rightBar.physicsBody = SKPhysicsBody(rectangleOf: verticalBarSize,
                                         center: CGPoint(x: verticalBarSize.width/2,
                                                         y: verticalBarSize.height/2))
    horizontalBar.physicsBody = SKPhysicsBody(rectangleOf: horizontalBarSize,
                                              center: CGPoint(x: horizontalBarSize.width/2,
                                                              y: horizontalBarSize.height/2))
    leftBar.physicsBody?.restitution = CGFloat(bordersRestitution)
    rightBar.physicsBody?.restitution = CGFloat(bordersRestitution)
    horizontalBar.physicsBody?.restitution = CGFloat(bordersRestitution)
    leftBar.physicsBody?.friction = CGFloat(friction)
    rightBar.physicsBody?.friction = CGFloat(friction)
    horizontalBar.physicsBody?.friction = CGFloat(friction)
    leftBar.physicsBody?.isDynamic = false
    rightBar.physicsBody?.isDynamic = false
    horizontalBar.physicsBody?.isDynamic = false
    
    scene.addChild(leftBar)
    scene.addChild(rightBar)
    scene.addChild(horizontalBar)
}

func drawScoreLabels(scene: SKScene, score:Int, ballsNumber: Int)->(SKLabelNode?,SKLabelNode?){
    
    let scoreLabel = SKLabelNode(text: "Score: " + String(score))
    scoreLabel.position = CGPoint(x: scoreLabelX,
                                  y: borderBarMid + 90)
    scoreLabel.fontColor = SKColor.white
    scoreLabel.fontSize = CGFloat(labelsFontSize)
    
    let livesLabel = SKLabelNode(text: "Balls: " + String(ballsNumber))
    livesLabel.position = CGPoint(x: borderBarMax - livesLabelDeltaX,
                                  y: borderBarMid + 90)
    livesLabel.fontColor = SKColor.white
    livesLabel.fontSize = CGFloat(labelsFontSize)
    
    scene.addChild(scoreLabel)
    scene.addChild(livesLabel)
    return (scoreLabel, livesLabel)
}

func drawPaddle(scene: SKScene)->SKSpriteNode?{
    
    let paddleSize = CGSize(width: paddleWidth, height: paddleHeight)
    let paddle = SKSpriteNode(color: SKColor.white, size: paddleSize)
    paddle.name = "paddle"
    paddle.anchorPoint = CGPoint(x: 0.5, y: 1)

    // Physics properties
    paddle.physicsBody = SKPhysicsBody(rectangleOf: paddleSize,
                                       center: CGPoint(x: 0,
                                                       y: -paddleHeight/2))
    paddle.physicsBody?.friction = CGFloat(friction)
    paddle.physicsBody?.restitution = CGFloat(paddleRestitution)
    paddle.physicsBody?.categoryBitMask = BodyType.paddle.rawValue
    paddle.physicsBody?.contactTestBitMask = BodyType.ball.rawValue
    paddle.physicsBody?.isDynamic = false
    //paddle.physicsBody?.allowsRotation = false
    
    scene.addChild(paddle)
    
    return paddle
}

func drawBricks(scene: SKScene) {
    
    var bricks = [SKSpriteNode]()
    
    for row in 0..<numRows {
        for col in 0..<numColumns {
            let brickSize = CGSize(width: brickWidth, height: brickHeight)
            let brick = SKSpriteNode(color: brickColors[row], size: brickSize)
            brick.anchorPoint = CGPoint.zero
            brick.name = "brick" + String((col+1)+row*numColumns)
            let brickPosition = CGPoint(x: brickFirstXPosition + brickWidthAndDelta*col,
                                        y: brickFirstYPosition - brickHeightAndDelta*row)
            brick.position = brickPosition
            
            // Physics properties
            brick.physicsBody = SKPhysicsBody(rectangleOf: brickSize,
                                              center: CGPoint(x: brickWidth/2,
                                                              y: brickHeight/2))
            brick.physicsBody?.friction = CGFloat(friction)
            brick.physicsBody?.restitution = CGFloat(bricksRestitution)
            brick.physicsBody?.categoryBitMask = BodyType.brick.rawValue
            brick.physicsBody?.contactTestBitMask = BodyType.ball.rawValue
            brick.physicsBody?.isDynamic = false
            
            bricks.append(brick)
        }
    }
    
    for brick in bricks {
        scene.addChild(brick)
    }
    
}

func drawBall(scene: SKScene,paddle: SKSpriteNode)->SKSpriteNode{
    let ballSize = CGSize(width: ballDim, height: ballDim)
    let ball = SKSpriteNode(color: SKColor.white, size: ballSize)
    //ball.anchorPoint = CGPoint.zero
    
    // Physics properties
    ball.physicsBody = SKPhysicsBody(rectangleOf: ballSize, center: ball.anchorPoint)
    ball.physicsBody?.friction = CGFloat(friction)
    ball.physicsBody?.restitution = CGFloat(ballRestitution)
    ball.physicsBody?.categoryBitMask = BodyType.ball.rawValue
    ball.physicsBody?.contactTestBitMask = BodyType.brick.rawValue
    ball.physicsBody?.affectedByGravity = false
    ball.physicsBody?.allowsRotation = false
    
    
    ball.name = "name"
    scene.addChild(ball)

    return ball
}

func gameOver(scene: SKScene, paddle: SKSpriteNode ) {
    
}

func drawSplashScreen(scene: SKScene) {

}

func showStartButton(scene: SKScene){

}

func nextLevel(scene: SKScene, paddle: SKSpriteNode , ball: SKSpriteNode ) {
    drawBricks(scene: scene)
    paddle.position = CGPoint(x: paddleX, y: paddleY)
    ball.position = CGPoint(x: paddleX, y: (paddleY + (paddleHeight/2)) )
}

func updateStatus(scoreLabel: SKLabelNode, livesLabel: SKLabelNode, score: Int, ballsNumber: Int){

}

