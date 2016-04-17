//
//  TowerLevel.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation
import CoreGraphics

protocol TowerLevel {
	static var fireRate: Float { get }
	static var range: CGFloat { get }
	static var damage: Float { get }
	static var price: Int { get }
	static var name: String { get }
}

let TowerLevels: [TowerLevel.Type] = [TowerLevel1.self, TowerLevel2.self, TowerLevel3.self]

struct TowerLevel1: TowerLevel {
	static var fireRate: Float {
		return 0.25
	}

	static var range: CGFloat {
		return 150.0
	}

	static var damage: Float {
		return 10.0
	}

	static var price: Int {
		return 100
	}

	static var name: String {
		return "Level 1"
	}
}

struct TowerLevel2: TowerLevel {
	static var fireRate: Float {
		return 0.25
	}

	static var range: CGFloat {
		return 175.0
	}

	static var damage: Float {
		return 75.0
	}

	static var price: Int {
		return 400
	}

	static var name: String {
		return "Level 2"
	}
}

struct TowerLevel3: TowerLevel {
	static var fireRate: Float {
		return 0.2
	}

	static var range: CGFloat {
		return 250.0
	}

	static var damage: Float {
		return 100.0
	}

	static var price: Int {
		return 1600
	}

	static var name: String {
		return "Level 3"
	}
}
