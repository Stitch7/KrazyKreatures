//
//  Cursor.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 21.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import SpriteKit

class Cursor: SKSpriteNode {

    // MARK: - Properties

    let selectorName = "Selector"
    var currentSelection: Square?
    var edgeLength: CGFloat = 51.0

    var hasSelection: Bool {
        return currentSelection != nil
    }

    // MARK: - Initializers

    init() {
        let texture = SKTexture(imageNamed: selectorName)
        let color = UIColor.clearColor()
        let size = CGSizeMake(edgeLength, edgeLength)
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func configure() {
        zPosition = 1.0
    }

    // MARK: - Public

    func select(square square: Square) {
        removeSelection()
        if square.hasCard {
            currentSelection = square
        }
        square.cursor = self
    }

    func removeSelection() {
        currentSelection?.cursor = nil
        currentSelection = nil
        removeFromParent()
    }
}
