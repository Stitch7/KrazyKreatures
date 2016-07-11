//
//  Cell.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 21.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

class Cell {

    // MARK: - Properties

    weak var board: Board?
    let col: Int
    let row: Int

    // MARK: - Initializers

    init(board: Board, col: Int, row: Int) {
        self.board = board
        self.col = col
        self.row = row
    }
}
