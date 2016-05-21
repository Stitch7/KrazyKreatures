//
//  GameViewController.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 19.05.16.
//  Copyright (c) 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.bounds.size)
//        let scene = StartGameScene(size: view.bounds.size)        
        scene.scaleMode = .AspectFill

        if let skView = self.view as? SKView {
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
//            skView.showsPhysics = true
            skView.presentScene(scene)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
