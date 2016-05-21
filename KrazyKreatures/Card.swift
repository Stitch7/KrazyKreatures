//
//  Player.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 19.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import SpriteKit

class Card: SKSpriteNode {

    var image: String

    init(withImage image: String) {
        self.image = image
        let texture = SKTexture(imageNamed: "\(image)\(1)")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())

        animate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func animate() {
        var textures = [SKTexture]()
        for i in 1...3 {
            textures.append(SKTexture(imageNamed: "\(image)\(i)"))
        }
        let playerAction = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let playerAnimation = SKAction.repeatActionForever(playerAction)
        runAction(playerAnimation)
    }
}
