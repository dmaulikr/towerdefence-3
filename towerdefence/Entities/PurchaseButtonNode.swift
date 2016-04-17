//
//  PurchaseButtonNode.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import SpriteKit

class PurchaseButtonNode: SKShapeNode {
	class func create() -> PurchaseButtonNode {
		let button = PurchaseButtonNode(rectOfSize: CGSize(width: 50, height: 50), cornerRadius: 5)
		button.setUp()
		return button
	}

	func setUp() {

		fillColor = SKColor(red: 111/255.0, green: 161/255.0, blue: 107/255.0, alpha: 1.0)
		strokeColor = fillColor

		let tower = TowerNode.create()
		tower.position.y += 8
		tower.enabled = false
		tower.userInteractionEnabled = false
		addChild(tower)

		let label = SKLabelNode()
		label.text = "$100"
		label.fontSize = 14
		label.fontName = "HelveticaNeueSemibold"
		label.position.y -= 20
		addChild(label)
	}
}
