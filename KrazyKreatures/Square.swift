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

    // MARK: - Properties

    let cell: Cell

    var edgeLength: CGFloat = 64.0
    var xOffset: CGFloat = 45.0
    var yOffset: CGFloat = 60.0

    var card: Card? {
        didSet {
            guard let card = self.card else { return }
            card.cell = cell
            card.removeFromParent()
            card.position = CGPointZero
            addChild(card)
        }
    }
    
    var hasCard: Bool {
        return card != nil
    }

    var isEmpty: Bool {0
        return card == nil
    }

    var cursor: Cursor? {
        didSet {
            guard let cursor = self.cursor else { return }
            addChild(cursor)
        }
    }

    var selected: Bool {
        return cursor != nil
    }

    // MARK: - Initializers

    init(cell: Cell) {
        self.cell = cell

        let size = CGSizeMake(edgeLength, edgeLength)
        super.init(texture: nil, color: SKColor.blackColor(), size: size)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func configure() {
        guard let board = cell.board else { fatalError("Cells board was too weak...") }
        zPosition = 0.0

        let posX = (CGFloat(cell.col) * size.width) + xOffset
        let posY = (CGFloat((cell.row - board.numRows) * -1) * size.height) + yOffset
        position = CGPointMake(posX, posY)
    }
}
