//
//  EnemyProtocol.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation
import CoreGraphics

protocol EnemyConfiguration {
	var velocity: CGFloat { get }
	var health: Float { get }
	var worth: Int { get }

	init()
}

struct BasicEnemy: EnemyConfiguration {
	var velocity: CGFloat {
		return 60.0
	}

	var health: Float {
		return 100.0
	}

	var worth: Int {
		return 10
	}
}

struct MediumEnemy: EnemyConfiguration {
	var velocity: CGFloat {
		return 110.0
	}

	var health: Float {
		return 300.0
	}

	var worth: Int {
		return 25
	}
}

struct HardEnemy: EnemyConfiguration {
	var velocity: CGFloat {
		return 60.0
	}

	var health: Float {
		return 2000.0
	}

	var worth: Int {
		return 100
	}
}