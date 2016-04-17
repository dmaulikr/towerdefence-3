//
//  MenuScreen.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import SpriteKit

#if os(OSX)
	extension SKView {
		var center: CGPoint {
			return CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
		}
	}
#endif

class MenuScene: SKScene {

	private let _label: SKLabelNode = SKLabelNode()
	private var _gameScene: SKScene!

	override func didMoveToView(view: SKView) {
		backgroundColor = SKColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)

		_gameScene = GameScene(size: view.bounds.size)

		_label.text = "START GAME"
		_label.fontName = "HeleveticaNeueBold"
		_label.fontColor = SKColor(white: 0.1, alpha: 1)
		addChild(_label)

		_label.position = view.center
	}

#if os(iOS)
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		guard let touch = touches.first else {
			return
		}

		let position = touch.locationInNode(self)

		if let skView = view where
			nodeAtPoint(position) is SKLabelNode {
			_gameScene.scaleMode = .AspectFill
			skView.presentScene(_gameScene, transition: SKTransition.fadeWithDuration(1.0))
		}
	}
#endif
}

#if os(OSX)
	extension MenuScene {
		override func mouseDown(theEvent: NSEvent) {
			let position = theEvent.locationInNode(self)
			if let skView = view where
				nodeAtPoint(position) is SKLabelNode {
				_gameScene.scaleMode = .AspectFill
				skView.presentScene(_gameScene, transition: SKTransition.fadeWithDuration(1.0))
			}
		}
	}
#endif