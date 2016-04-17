//
//  TowerCanonNode.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import SpriteKit

class TowerCanonNode: SKNode {

	class func create() -> TowerCanonNode {
		let canon = TowerCanonNode()
		canon.setUp()
		return canon
	}

	private func setUp() {
		let path = CGPathCreateMutable()
		CGPathMoveToPoint(path, nil, 0, -5)
		CGPathAddLineToPoint(path, nil, 0, 5)
		CGPathAddLineToPoint(path, nil, 20, 0)
		CGPathCloseSubpath(path)

		let shape = SKShapeNode(path: path)
		shape.lineWidth = 0.5
		shape.fillColor = SKColor(white: 0.29, alpha: 1)
		shape.strokeColor = shape.fillColor
		addChild(shape)
	}

	func update(dt: CFTimeInterval) { }
}