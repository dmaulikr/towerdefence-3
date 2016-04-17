//
//  TowerNode+InputEvents.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//


#if os(iOS)
	import UIKit
	extension TowerNode {
		override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
			guard let touch = touches.first else {
				return
			}

			let position = touch.locationInNode(self)
			if touchBegan(position) {
				super.touchesBegan(touches, withEvent: event)
			}
		}
	}
#endif

#if os(OSX)
	import AppKit
	extension TowerNode {
		override func mouseDown(theEvent: NSEvent) {
			let pt = theEvent.locationInNode(self)
			touchBegan(pt)
		}
	}
#endif