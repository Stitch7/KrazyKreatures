//
//  Square.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 21.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit
import SpriteKit

class Square: SKSpriteNode {

    // MARK: - Initializers

    init(name: String, size: CGSize, position: CGPoint) {
        let texture = SKTexture()
        let size = CGSizeZero
        super.init(texture: texture, color: SKColor.blackColor(), size: size)

        self.position = position
        self.name = name
        zPosition = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
