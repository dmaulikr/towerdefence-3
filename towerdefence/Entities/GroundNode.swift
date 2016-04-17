//
//  GroundPath.swift
//  towerdefence
//
//  Created by Simon Andersson on 16/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation
import SpriteKit

struct Ground {
	var points: [CGPoint]
}

class GroundNode: SKShapeNode {

	private var _ground: Ground?
	var ground: Ground? {
		set {
			self._ground = newValue
			updatePath()
		}
		get {
			return self._ground
		}
	}

	class func create(ground: Ground?) -> GroundNode {
		let groundNode = GroundNode(ground: ground)
		groundNode.setUp()
		return groundNode
	}

	init(ground: Ground?) {
		super.init()
		_ground = ground
	}

	override init() {
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	func setUp() {
		strokeColor = SKColor(white: 0.59, alpha: 1.0)
		lineWidth = 30
		lineJoin = CGLineJoin.Miter
		miterLimit = 30
	}

	func updatePath() {
		guard let ground = _ground else {
			return;
		}

		let groundPath = CGPathCreateMutable()
		let points = ground.points

		if let firstPoint = points.first {
			CGPathMoveToPoint(groundPath, nil, firstPoint.x, firstPoint.y)
		}

		for i in 1.stride(to: points.count, by: 1) {
			CGPathAddLineToPoint(groundPath, nil, points[i].x, points[i].y)
		}

		path = groundPath
	}
}