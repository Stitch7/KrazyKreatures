//
//  Board.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 21.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation
import SpriteKit

class Board {

    // MARK: - Properties

    weak var scene: SKScene?

    var squares = [Square]()
    var animals: Animal = .Cat

    let numRows = 5
    let numCols = 10
    let maxCardCount = 25
    let newCardsDelay: NSTimeInterval = 1

    var maxSquares: Int {
        return numRows * numCols
    }

    // MARK: - Initializers

    init(scene: SKScene) {
        self.scene = scene
        draw(scene)
    }

    private func draw(scene: SKScene) {
        for row in 0..<numRows {
            for col in 0..<numCols {
                let cell = Cell(board: self, col: col, row: numRows-row)
                let square = Square(cell: cell)
                squares.append(square)
                scene.addChild(square)
            }
        }
    }

    // MARK: - Public

    func dealCards() {
        let dealRandomCardAction = SKAction.sequence([
            SKAction.waitForDuration(newCardsDelay),
            SKAction.runBlock {
                guard let square = self.emptySquareWithRandomCard() where square.hasCard else { return }
                self.addCard(square.card!, toSquare: square)
            }
        ])
        scene?.runAction(SKAction.repeatAction(dealRandomCardAction, count: maxCardCount))
    }

    func addCard(card: Card, toSquare square: Square) {
        scene?.runAction(SKAction.playSoundFileNamed("newCard.m4a", waitForCompletion: false))

        // Deliver card to main scene for animation
        card.removeFromParent()
        card.position = CGPointZero
        scene?.addChild(card)

        let screenHalf = UIScreen.mainScreen().bounds.width / 2
        var startCorner = SceneCorners.BottomLeft
        var controlPoint = (x: square.position.x - 80, y: square.position.y + 200)
        if square.position.x > screenHalf {
            startCorner = .BottomRight
            controlPoint.x = square.position.x + 80
        }

        let path = CGPathCreateMutable()
        let startPosition = startCorner.position
        CGPathMoveToPoint(path, nil, startPosition.x, startPosition.y)
        CGPathAddCurveToPoint(path, nil,
                              controlPoint.x, controlPoint.y,
                              controlPoint.x, controlPoint.y,
                              square.position.x, square.position.y)

        let curve = SKAction.followPath(path,
                                        asOffset: false,
                                        orientToPath: false,
                                        duration: newCardsDelay - 0.1)

        let action = SKAction.sequence([
            curve,
            SKAction.runBlock { [card, square]
                card.removeFromParent()
                square.card = card
            }])
        action.timingMode = .EaseInEaseOut
        card.runAction(action)
    }

    // MARK: - Repo

    func emptySquareWithRandomCard() -> Square? {
        var iterations = maxSquares
        repeat {
            iterations -= 1
            let rndSquare = randomSquare()
            if rndSquare.isEmpty {
                rndSquare.card = Card(cell: rndSquare.cell, animal: animals.next())
                return rndSquare
            }
        } while iterations >= 0

        return nil
    }

    func randomSquare() -> Square {
        let randomIndex = Int(arc4random_uniform(UInt32(squares.count)))
        return squares[randomIndex]
    }

    func squareWithCell(row: Int, col: Int) -> Square? {
        for square in squares {
            if square.cell.row == row && square.cell.col == col {
                return square
            }
        }

        return nil
    }

    func squareWithCard(card: Card?) -> Square? {
        guard let card = card else { return nil }

        for square in squares {
            if square.card == card {
                return square
            }
        }

        return nil
    }
}
