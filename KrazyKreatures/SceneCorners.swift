//
//  SceneCorners.swift
//  KrazyKreatures
//
//  Created by Christopher Reitz on 20.05.16.
//  Copyright © 2016 Christopher Reitz. All rights reserved.
//

import UIKit

enum SceneCorners {
    case BottomLeft
    case BottomRight
    case TopLeft
    case TopRight

    var sorted: [SceneCorners] {
//        return [.BottomLeft, .TopRight ,BottomRight, .TopLeft]
//        return [.BottomLeft, BottomRight]
        return [.BottomLeft]
    }

    var position: (x: CGFloat, y: CGFloat) {
        let screenSize = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        switch self {
        case .BottomLeft: return (0, 0)
        case .BottomRight: return (screenWidth, 0)
        case .TopLeft: return (0, screenWidth)
        case .TopRight: return (screenHeight, screenWidth)
        }
    }

    mutating func nextValue() -> SceneCorners {
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
