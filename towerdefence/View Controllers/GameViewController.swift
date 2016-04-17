//
//  GameViewController.swift
//  towerdefence
//
//  Created by Simon Andersson on 16/04/16.
//  Copyright (c) 2016 Hiddencode.me. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let skView = self.view as! SKView
		skView.showsFPS = true
		skView.showsNodeCount = true
		
		/* Sprite Kit applies additional optimizations to improve rendering performance */
		skView.ignoresSiblingOrder = true
		
		/* Set the scale mode to scale to fit the window */
	}

	override func viewWillLayoutSubviews() {
		let skView = self.view as! SKView

		if skView.scene == nil {
			let scene: SKScene = MenuScene(size: skView.bounds.size)
			scene.scaleMode = .AspectFill
			skView.presentScene(scene)
		}
	}

	override func shouldAutorotate() -> Bool {
		return false
	}
	
	override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
			return .AllButUpsideDown
		} else {
			return .All
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}
