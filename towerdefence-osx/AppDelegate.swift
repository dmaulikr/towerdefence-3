//
//  AppDelegate.swift
//  towerdefence-osx
//
//  Created by Simon Andersson on 16/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		// Insert code here to initialize your application
		let scene = MenuScene(size: window.frame.size)
		// Configure the view.
		let skView = window.contentView as! SKView
		
		/* Sprite Kit applies additional optimizations to improve rendering performance */
		skView.ignoresSiblingOrder = true
		
		/* Set the scale mode to scale to fit the window */
		scene.scaleMode = .AspectFill
		
		skView.presentScene(scene)
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
}

