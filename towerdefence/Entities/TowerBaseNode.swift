//
//  TowerBaseNode.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import SpriteKit

class TowerBaseNode: SKNode {
	class func create() -> TowerBaseNode {
		let base = TowerBaseNode()
		base.setUp()
		return base
	}

	private func setUp() {
		level1()
	}

	func upgrade(toLevel level: TowerLevel.Type) {
		switch level {
		case is TowerLevel1.Type:
			level1()
		case is TowerLevel2.Type:
			level2()
		case is TowerLevel3.Type:
			level3()
		default:
			level1()
		}
	}

	private func level1() {
		removeAllChildren()
		let circle = SKShapeNode(circleOfRadius: 12)
		circle.lineWidth = 0.5
		circle.fillColor = SKColor(white: 0.65, alpha: 1)
		circle.strokeColor = circle.fillColor
		addChild(circle)
	}

	private func level2() {

		removeAllChildren()

		let rectangle = SKShapeNode(rectOfSize: CGSize(width: 24, height: 24))
		rectangle.fillColor = SKColor(white: 0.65, alpha: 1.0)
		rectangle.strokeColor = rectangle.fillColor
		rectangle.lineWidth = 0.5
		addChild(rectangle)

		let circle = SKShapeNode(circleOfRadius: 12)
		circle.lineWidth = 0.5
		circle.fillColor = SKColor(white: 0.45, alpha: 1)
		circle.strokeColor = circle.fillColor
		addChild(circle)
	}

	private func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,adjustment:CGFloat=0)->[CGPoint] {
		let angle = CGFloat(M_PI * 2)/CGFloat(sides)
		let cx = x // x origin
		let cy = y // y origin
		let r  = radius // radius of circle
		var i = sides
		var points = [CGPoint]()
		while points.count <= sides {
			let xpo = cx - r * cos(angle * CGFloat(i))
			let ypo = cy - r * sin(angle * CGFloat(i))
			points.append(CGPoint(x: xpo, y: ypo))
			i -= 1;
		}
		return points
	}

	private func level3() {

		removeAllChildren()

		let polygonArray: [CGPoint] = polygonPointArray(6, x: 0, y: 0, radius: 20)
		let path = CGPathCreateMutable()// UIBezierPath()
		CGPathMoveToPoint(path, nil, polygonArray[0].x, polygonArray[0].y)

		for i in 1.stride(to: polygonArray.count, by: 1) {
			CGPathAddLineToPoint(path, nil, polygonArray[i].x, polygonArray[i].y)
		}

		let rectangle = SKShapeNode(path: path)
		rectangle.fillColor = SKColor(white: 0.65, alpha: 1.0)
		rectangle.strokeColor = rectangle.fillColor
		rectangle.lineWidth = 0.5
		addChild(rectangle)

		let circle = SKShapeNode(circleOfRadius: 12)
		circle.lineWidth = 0.5
		circle.fillColor = SKColor(white: 0.45, alpha: 1)
		circle.strokeColor = circle.fillColor
		addChild(circle)
	}

	func update(dt: CFTimeInterval) { }
}
