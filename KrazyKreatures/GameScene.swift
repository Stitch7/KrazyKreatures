//
//  GameScene.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 19.05.16.
//  Copyright (c) 2016 Christopher Reitz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    // MARK: - Properties

    var board: Board!
    var referee: Referee!
    var cursor = Cursor()

    // MARK: - SKScene

    override func didMoveToView(view: SKView) {
        backgroundColor = ColorPalette.background
        scaleMode = .ResizeFill

        board = Board(scene: self)
        board.dealCards()

        referee = Referee(scene: self, board: board)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchLocation = touch.locationInNode(self)
        let touchedNode = nodeAtPoint(touchLocation)

        switch touchedNode {
        case let square as Square: squareTouched(square)
        case let card as Card: cardTouched(card)
        default: break
        }
    }

    // MARK: - Events

    func squareTouched(square: Square) {
        if cursor.hasSelection {
            if square.hasCard {
                // play möp, can not move card to square with card
                return
            }

            // move card
            let card = cursor.currentSelection!.card!
            square.card = card
            referee.checkBingo(card)
            cursor.removeSelection()
        }
        else {
            cursor.select(square: square)
        }
    }

    func cardTouched(card: Card) {
        if cursor.hasSelection {
            // play möp, can not move card to square with card
            return
        }

        if let squareWithCard = board.squareWithCard(card) {
            cursor.select(square: squareWithCard)
        }
    }
}
