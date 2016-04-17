//
//  CGPoint+Extra.swift
//  svang-tvos
//
//  Created by Andreas Areschoug on 30/01/16.
//  Copyright © 2016 svang. All rights reserved.
//

import CoreGraphics

extension CGPoint {
  func distance(to: CGPoint) -> CGFloat {
    let xDist = to.x - x
    let yDist = to.y - y
    return sqrt(xDist * xDist + yDist * yDist)
  }
}