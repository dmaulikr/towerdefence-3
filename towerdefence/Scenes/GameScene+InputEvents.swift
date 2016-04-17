//
//  GameScene+InputEvents.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

#if os(iOS)
	import UIKit
	extension GameScene {
		override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
			guard let touch = touches.first else {
				return
			}

			let position = touch.locationInNode(self)

			if touchBegan(position) {
				super.touchesBegan(touches, withEvent: event)
			}
		}

		override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
			guard let touch = touches.first else {
				return
			}

			var position = touch.locationInNode(self)
			touchMoved(&position)
		}

		override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
			guard let touch = touches.first else {
				return
			}

			let position = touch.locationInNode(self)
			touchEnded(position)
		}
	}
#endif

#if os(OSX)
	import AppKit
	extension GameScene {
		override func mouseDown(theEvent: NSEvent) {
			let pt = theEvent.locationInNode(self)
			touchBegan(pt)
		}

		override func mouseDragged(theEvent: NSEvent) {
			var pt = theEvent.locationInNode(self)
			touchMoved(&pt)
		}

		override func mouseUp(theEvent: NSEvent) {
			let pt = theEvent.locationInNode(self)
			touchEnded(pt)
		}
	}
#endif