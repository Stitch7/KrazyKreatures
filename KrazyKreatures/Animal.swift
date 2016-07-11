//
//  GameCards.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 20.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import Foundation

enum Animal {
    case Cat
    case Dog

    var sorted: [Animal] {
        return [.Cat, .Dog]
    }

    mutating func next() -> Animal {
        let sorted = self.sorted
        let currentIndex = sorted.indexOf(self)!
        var nextIndex = currentIndex + 1
        if sorted.count <= nextIndex {
            nextIndex = 0
        }

        self = sorted[nextIndex]
        return self
    }
}