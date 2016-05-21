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

    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()

        let title = SKLabelNode(fontNamed: "Emulogic")
        title.text = "Krazy Kreatures"
        title.fontSize = 20
        title.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame) + 80)
        addChild(title)

        let startGameButton = PulsatingText(fontNamed: "Emulogic")
        startGameButton.setTextFontSizeAndPulsate("START NEW GAME", fontSize: 10)
        startGameButton.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 60)
        startGameButton.name = "StartGameButton"
        addChild(startGameButton)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchLocation = touch.locationInNode(self)
        let touchedNode = nodeAtPoint(touchLocation)
        if touchedNode.name == "StartGameButton" {
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
    }
}
