//
//  GameViewController.swift
//  breakout
//
//  Created by Ignazio Finizio on 19/02/2017.
//  Copyright © 2017 Ignazio Finizio. All rights reserved.
//

import UIKit
import SpriteKit
class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        skView.presentScene(scene)
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true
        scene.physicsWorld.contactDelegate = scene
        scene.scaleMode = .aspectFill
        scene.drawScene(scene: scene)
        scene.paddle?.position = CGPoint(x: paddleX, y: paddleY)
        scene.ball?.position = CGPoint(x: paddleX, y: (paddleY + (paddleHeight/2)) )
        scene.ball?.physicsBody?.velocity = CGVector(dx: 800, dy: 800)
        skView.presentScene(scene)
    }
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
} 
