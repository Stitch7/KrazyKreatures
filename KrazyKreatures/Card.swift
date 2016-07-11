//
//  Card.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 19.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import SpriteKit

// MARK: - Equatable

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.animal == rhs.animal
}

class Card: SKSpriteNode {

    // MARK: - Properties

    var cell: Cell
    var animal: Animal
    var edgeLength: CGFloat = 51.0

    // MARK: - Initializers

    init(cell: Cell, animal: Animal) {
        self.cell = cell
        self.animal = animal
        let texture = SKTexture(imageNamed: "\(animal)\(1)")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())

        configure()
        animate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func configure() {
        size = CGSizeMake(edgeLength, edgeLength)
        zPosition = 2.0
    }

    private func animate() {
        var textures = [SKTexture]()
        for i in 1...3 {
            textures.append(SKTexture(imageNamed: "\(animal)\(i)"))
        }
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        runAction(SKAction.repeatActionForever(animateAction))
    }
}
