//
//  SKView+MouseEvents.swift
//  svang-tvos
//
//  Created by Simon Andersson on 10/01/16.
//  Copyright © 2016 svang. All rights reserved.
//

import SpriteKit

extension SKView {
	public override func mouseDown(theEvent: NSEvent) {
		self.scene?.mouseDown(theEvent)
	}

	public override func mouseDragged(theEvent: NSEvent) {
		self.scene?.mouseDragged(theEvent)
	}

	public override func mouseUp(theEvent: NSEvent) {
		self.scene?.mouseUp(theEvent)
	}

	public override func rightMouseDown(theEvent: NSEvent) {
		self.scene?.rightMouseDown(theEvent)
	}

	public override func rightMouseUp(theEvent: NSEvent) {
		self.scene?.rightMouseUp(theEvent)
	}
}