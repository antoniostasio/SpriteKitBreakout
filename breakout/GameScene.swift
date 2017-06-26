//
//  GameScene.swift
//  breakout
//
//  Created by Ignazio Finizio on 19/02/2017.
//  Copyright © 2017 Ignazio Finizio. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ballStarted = false
    var ballsNumber = 0
    var score = 0
    var ball: SKSpriteNode?
    var paddle: SKSpriteNode?
    var scoreLabel: SKLabelNode?
    var livesLabel: SKLabelNode?
    var paddleMovement = Movement()
    
    
    override func update(_ currentTime: TimeInterval) {
        movePaddle()
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
    }
    
    func drawScene(scene: SKScene) {
        
        drawBorders(scene: scene)
        drawBricks(scene: scene)
        paddle = drawPaddle(scene: scene)
        
        ball = drawBall(scene: scene, paddle: paddle!)
        
        _ = drawScoreLabels(scene: scene, score: 0 , ballsNumber: maxBallsNumber)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if ((touches.first?.location(in: self).x)! > self.size.width/2) {
            paddleMovement.isMoving = true
            paddleMovement.direction = Directions.right
        }
        else {
            paddleMovement.isMoving = true
            paddleMovement.direction = Directions.left
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //buttons
        super.touchesEnded(touches, with: event)
        paddleMovement.isMoving = false
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let brickCollisionMask = BodyType.ball.rawValue | BodyType.brick.rawValue
        if (contactMask == brickCollisionMask) {
            let brick = (contact.bodyA.categoryBitMask == BodyType.brick.rawValue) ? contact.bodyA.node : contact.bodyB.node
            self.removeChildren(in: [brick!])
        }
    }
    
    func movePaddle() {
        if (paddleMovement.isMoving) {
            let velocity: CGFloat = paddleMovement.direction.rawValue * 25
            paddle?.position.x += velocity
            let rightLimit = self.size.width - CGFloat(borderBarMin + paddleWidth/2)
            let leftLimit = CGFloat(borderBarMin + paddleWidth/2)
            if ( (paddle?.position.x)! > rightLimit) {
                paddle?.position.x = rightLimit
            }
            else if ( (paddle?.position.x)! < leftLimit) {
                paddle?.position.x = leftLimit
            }
        }
    }
    
}

// Internal types
extension GameScene {
    enum Directions: CGFloat {
        case left = -1
        case right = 1
    }
    struct Movement {
        var isMoving: Bool = false
        var direction: Directions = Directions.right
    }
}
