//
//  StartGameScene.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 19.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: SKScene {

    // MARK: - SKScene

    override func didMoveToView(view: SKView) {
        configure()
    }

    func configure() {
        backgroundColor = ColorPalette.background
        configureTitleLabel()
        configureStartGameLabel()
    }

    func configureTitleLabel() {
        let titleLabel = SKLabelNode(fontNamed: "Emulogic")
        titleLabel.text = "Krazy Kreatures"
        titleLabel.fontSize = 20
        titleLabel.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame) + 80)
        addChild(titleLabel)
    }

    func configureStartGameLabel() {
        let startGameLabel = PulsatingText(fontNamed: "Emulogic")
        startGameLabel.pulsate(text: "START NEW GAME", fontSize: 10)
        startGameLabel.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 60)
        addChild(startGameLabel)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        startGame()
    }

    func startGame() {
        let gameOverScene = GameScene(size: size)
        gameOverScene.scaleMode = scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
        view?.presentScene(gameOverScene, transition: transitionType)
    }
}
