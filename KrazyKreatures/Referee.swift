//
//  Referee.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 28.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import SpriteKit

class Referee {

    weak var scene: SKScene?
    let board: Board
    let matchCount = 3

    init(scene: SKScene, board: Board) {
        self.scene = scene
        self.board = board
    }

    func checkBingo(card: Card) {
        //        let col = String(card.name!.characters.first!)
        //        let row = Int(String(card.name!.characters.last!))!
        //        let iCol = Int(col.unicodeScalars.first!.value) - 96

        let col = card.cell.col
        let row = card.cell.col


        print("~~~~~~~~~~")
        print(col, row)
        //
        //        var siblingsV = [Card]()
        //        var siblingsH = [Card]()
        //
        //        // Collect siblings to downwards
        //        for rowToCheck in row+1...row+3 {
        //            guard rowToCheck <= board.numRows else { break }
        //
        //            let name = "\(col)\(rowToCheck)"
        //            print(name)
        //            guard let cardToCheck = compareCard(card, withSquareOfName: name) else { break }
        //
        //            siblingsH.append(cardToCheck)
        //        }
        //
        //        // Collect siblings to upwards
        //        if row > 1 {
        //            for rowToCheck in (row-3...row-1).reverse() {
        //                guard rowToCheck > 0 else { continue }
        //
        //                let name = "\(col)\(rowToCheck)"
        //                guard let cardToCheck = compareCard(card, withSquareOfName: name) else { break }
        //
        //                siblingsH.append(cardToCheck)
        //            }
        //        }
        //
        //        // Collect siblings to the left
        //        for colToCheck in (iCol-3...iCol-1).reverse() {
        //            guard colToCheck <= board.numCols else { break }
        //
        //            let colToCheckChar = String(UnicodeScalar(colToCheck + 96))
        //            let name = "\(colToCheckChar)\(row)"
        //            guard let cardToCheck = compareCard(card, withSquareOfName: name) else { break }
        //
        //            siblingsV.append(cardToCheck)
        //        }
        //
        //        // Collect siblings to the right
        //        for colToCheck in iCol+1...iCol+3 {
        //            guard colToCheck <= board.numCols else { break }
        //
        //            let colToCheckChar = String(UnicodeScalar(colToCheck + 96))
        //            let name = "\(colToCheckChar)\(row)"
        //            guard let cardToCheck = compareCard(card, withSquareOfName: name) else { break }
        //
        //            siblingsV.append(cardToCheck)
        //        }
        //
        //        if siblingsV.count >= matchCount || siblingsH.count >= matchCount {
        //            let screenHeight = UIScreen.mainScreen().bounds.height
        //            let curve = SKAction.moveTo(CGPointMake(0, screenHeight), duration: 0.5)
        //            for card in siblingsV + siblingsH {
        //                let square = card.parent!
        //                card.removeFromParent()
        //                card.position = square.position
        //                scene.addChild(card)
        //                let action = SKAction.sequence([
        //                    curve,
        //                    SKAction.runBlock { [card]
        //                        card.removeFromParent()
        //                    }])
        //                action.timingMode = .Linear
        //                card.runAction(action)
        //            }
        //        }
        //
        //        print(siblingsV.count)
        //        print(siblingsH.count)
        //        print("-----------")
    }

    private func compareCard(card: Card, withSquareOfName squareToCheckName: String) -> Card? {
//        if let cardToCheck = board.squareWithName(squareToCheckName)?.card {
//            if cardToCheck == card {
//                return cardToCheck
//            }
//        }

        return nil
    }

}