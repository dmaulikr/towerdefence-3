//
//  UpgradeNode.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import SpriteKit

class UpgradeNode: SKSpriteNode {
	let _upLabel: SKLabelNode = SKLabelNode()
	let _priceLabel: SKLabelNode = SKLabelNode()

	private var _levelText: String? = nil
	var levelText: String? {
		set {
			_levelText = String(format: "⬆️ %@", newValue!)
			_upLabel.text = _levelText
		}
		get {
			return _levelText
		}
	}

	private var _priceText: String? = nil
	var priceText: String? {
		set {
			_priceText = newValue
			_priceLabel.text = _priceText
		}
		get {
			return _priceText
		}
	}

	class func create() -> UpgradeNode {
		let upgradeNode = UpgradeNode()
		upgradeNode.setUp()
		return upgradeNode
	}

	init() {
		super.init(texture: nil, color: .blueColor(), size: .zero)
		setUp()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	func setUp() {
		_upLabel.fontName = "HelveticaNeue"
		_upLabel.fontSize = 12
		_upLabel.fontColor = .blackColor()
		_upLabel.horizontalAlignmentMode = .Center
		_upLabel.position.y = 12
		addChild(_upLabel)

		_priceLabel.fontName = "HelveticaNeue"
		_priceLabel.fontSize = 9
		_priceLabel.fontColor = .blackColor()
		_priceLabel.horizontalAlignmentMode = .Center
		addChild(_priceLabel)
	}
}
