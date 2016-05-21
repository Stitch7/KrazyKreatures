//
//  GameScene.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 19.05.16.
//  Copyright (c) 2016 Christopher Reitz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var board = [String]()
    var gameCards = GameCards.Cat
    var screenCorners = SceneCorners.BottomLeft

    let numRows = 5
    let numCols = 10
    let matchCount = 3
    let maxCardCount = 25
    let newCardsDelay: NSTimeInterval = 1

    let selectorName = "Selector"
    var currentSelection: String?

    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(red: 0.08, green: 0.07, blue: 0.65, alpha: 1.0)
//        backgroundColor = UIColor.blackColor()
        scaleMode = .ResizeFill

        generateBoard()
        drawBoard()
        startThrowingCards()
    }

    func generateBoard() {
        for row in 0...numRows-1 {
            for col in 0...numCols-1 {
                let colChar = String(UnicodeScalar(col + 97))
                let cellName = "\(colChar)\(numRows-row)"
                board.append(cellName)
            }
        }
    }

    func startThrowingCards() {
        let addRandomCardAction = SKAction.sequence([
            SKAction.waitForDuration(newCardsDelay),
            SKAction.runBlock {
                self.addRandomCard()
            }
        ])
        runAction(SKAction.repeatAction(addRandomCardAction, count: maxCardCount))
    }

    func randomSquareName() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(board.count)))
        return board[randomIndex]
    }

    func addRandomCard() {
        repeat {
            let squareName = randomSquareName()
            let existingCard = cardFromSquareWithName(squareName)
            if existingCard == nil {
                add(card: gameCards.nextValue(), toSquare: squareName)
                return
            }
        } while true
    }

    override func update(currentTime: CFTimeInterval) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchLocation = touch.locationInNode(self)
        let touchedNode = nodeAtPoint(touchLocation)

        // Prevent double selection
        guard touchedNode.name != selectorName else { return }

        removeOldSelection()
        if let movedCard = moveCard(touchedNode) {
            checkBingo(movedCard)
        }
        else {
            addNewSelection(touchedNode)
        }
    }

    func removeOldSelection() {
        guard let oldSelection = currentSelection else { return }
        guard let oldSquare = squareWithName(oldSelection) else { return }
        guard let oldSelector = oldSquare.childNodeWithName(selectorName) else { return }

        oldSelector.removeFromParent()
    }

    func moveCard(destinationNode: SKNode) -> Card? {
        guard let oldSelection = currentSelection else { return nil }
        guard let oldSelectedSquare = squareWithName(oldSelection) else { return nil }
        guard let oldSelectedSquareName = oldSelectedSquare.name else { return nil }
        guard let oldSelectedCard = oldSelectedSquare.childNodeWithName(oldSelectedSquareName) as? Card else { return nil }
        // Only move to empty squares
        if destinationNode.zPosition != 0.0 {
            addNewSelection(oldSelectedSquare)
            return Card(withImage: "") // TODO
        }

        oldSelectedCard.removeFromParent()
        oldSelectedCard.name = destinationNode.name
        destinationNode.addChild(oldSelectedCard)

        return oldSelectedCard
    }

    func checkBingo(card: Card) {
        let col = String(card.name!.characters.first!)
        let row = Int(String(card.name!.characters.last!))!
        let iCol = Int(col.unicodeScalars.first!.value) - 96

        var siblingsV = [Card]()
        var siblingsH = [Card]()

        // Collect siblings to the right
        for rowToCheck in row+1...row+3 {
            guard rowToCheck <= numRows else { break }

            let squareToCheckName = "\(col)\(rowToCheck)"
            if let cardToCheck = compareCard(card, withSquareOfName: squareToCheckName) {
                siblingsH.append(cardToCheck)
            }
            else {
                break
            }
        }

        // Collect siblings to the left
        if row > 1 {
            for rowToCheck in (row-3...row-1).reverse() {
                guard rowToCheck > 0 else { continue }

                let squareToCheckName = "\(col)\(rowToCheck)"
                if let cardToCheck = compareCard(card, withSquareOfName: squareToCheckName) {
                    siblingsH.append(cardToCheck)
                }
                else {
                    break
                }
            }
        }

        // Collect siblings to upwards
        for colToCheck in (iCol-3...iCol-1).reverse() {
            guard colToCheck <= numCols else { break }

            let colToCheckChar = String(UnicodeScalar(colToCheck + 96))
            let squareToCheckName = "\(colToCheckChar)\(row)"
            if let cardToCheck = compareCard(card, withSquareOfName: squareToCheckName) {
                siblingsV.append(cardToCheck)
            }
            else {
                break
            }
        }

        // Collect siblings to downwards
        for colToCheck in iCol+1...iCol+3 {
            guard colToCheck <= numCols else { break }

            let colToCheckChar = String(UnicodeScalar(colToCheck + 96))
            let squareToCheckName = "\(colToCheckChar)\(row)"
            if let cardToCheck = compareCard(card, withSquareOfName: squareToCheckName) {
                siblingsV.append(cardToCheck)
            }
            else {
                break
            }
        }

        if siblingsV.count >= matchCount || siblingsH.count >= matchCount {
//            card.removeFromParent()
            let screenHeight = UIScreen.mainScreen().bounds.height
            print((x: 0, y: screenHeight + 10))

            let curve = SKAction.moveTo(CGPointMake(0, screenHeight), duration: 0.5)
            for card in siblingsV + siblingsH {
                let square = card.parent!
                card.removeFromParent()
                card.position = square.position
                addChild(card)
                let action = SKAction.sequence([
                    curve,
                    SKAction.runBlock { [card]
                        card.removeFromParent()
                    }])
                action.timingMode = .Linear
                card.runAction(action)

            }
        }
    }

    func compareCard(card: Card, withSquareOfName squareToCheckName: String) -> Card? {
        if let cardToCheck = cardFromSquareWithName(squareToCheckName) {
            if cardToCheck.image.characters.first == card.image.characters.first {
                return cardToCheck
            }
        }

        return nil
    }

    func cardFromSquareWithName(name: String) -> Card? {
        guard let squareToCheck = squareWithName(name) else { return nil }
        guard let childSquare = squareToCheck.childNodeWithName(name) else { return nil }
        guard let card = childSquare as? Card else { return nil }

        return card
    }

    func addNewSelection(node: SKNode) {
        currentSelection = node.name
        let texture = SKTexture(imageNamed: selectorName)
        let color = UIColor.clearColor()
        let size = CGSizeMake(51, 51)
        let selector = SKSpriteNode(texture: texture, color: color, size: size)
        selector.name = selectorName
        selector.zPosition = 1.0

        if let square = squareWithName(currentSelection) {
            square.addChild(selector)
        }
    }

    func add(card card: String, toSquare squareName: String) {
        guard let square = squareWithName(squareName) else {
            fatalError("Overflow: square with name \(squareName) does not exist")
        }

        let newCard = Card(withImage: card)
        newCard.position = CGPointZero
        newCard.zPosition = 2.0
        newCard.name = square.name
        newCard.size = CGSizeMake(51, 51)
        addChild(newCard)
        runAction(SKAction.playSoundFileNamed("newCard.m4a", waitForCompletion: false))

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
            SKAction.runBlock { [newCard, square]
                newCard.removeFromParent()
                newCard.position = CGPointZero
                square.addChild(newCard)
            }])
        action.timingMode = .EaseInEaseOut
        newCard.runAction(action)
    }

    func drawBoard() {
        let squareSize = CGSizeMake(64, 64)
        let xOffset = CGFloat(45)
        let yOffset = CGFloat(60)

        for row in 0...numRows-1 {
            for col in 0...numCols-1 {
                let square = SKSpriteNode(color: SKColor.blackColor(), size: squareSize)
                let squarePosX = CGFloat(col) * squareSize.width + xOffset
                let squarePosY = CGFloat(row) * squareSize.height + yOffset
                square.zPosition = 0.0
                square.position = CGPointMake(squarePosX, squarePosY)

                // Set sprite's name (e.g., a8, c5, d1)
                let colChar = String(UnicodeScalar(col + 97))
                square.name = "\(colChar)\(numRows-row)"
//                print("row: \(row), col: \(col) => \(square.name!) ")
                addChild(square)
            }
        }
    }

    func squareWithName(name: String?) -> SKSpriteNode? {
        guard let name = name else { return nil }
        return childNodeWithName(name) as? SKSpriteNode
    }


}
