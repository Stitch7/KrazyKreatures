//
//  PulsatingText.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 19.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import SpriteKit

class PulsatingText: SKLabelNode {
    func pulsate(text newText: String, fontSize newFontSize: CGFloat) {
        text = newText
        fontSize = newFontSize

        let scaleSequence = SKAction.sequence([SKAction.scaleTo(1.5, duration: 1), SKAction.scaleTo(1.0, duration:1)])
        let scaleForever = SKAction.repeatActionForever(scaleSequence)
        runAction(scaleForever)
    }
}
