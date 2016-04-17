//
//  ProjectileNode.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation
import SpriteKit

class ProjectileNode: SKShapeNode {
	private var _tower: TowerNode!
	var tower: TowerNode {
		return _tower
	}
	private var _targetEnemy: EnemyNode!
	var targetEnemy: EnemyNode {
		return _targetEnemy
	}

	var collides: Bool {
		return _alive && CGRectContainsPoint(_targetEnemy.calculateAccumulatedFrame(), self.position)
	}

	private var _alive: Bool = true
	var alive: Bool {
		set {
			_alive = newValue
		}
		get {
			return _alive
		}
	}

	class func create(fromTower: TowerNode, targetEnemy: EnemyNode) -> ProjectileNode {
		let projectile = ProjectileNode(rect: CGRect(x: 0, y: 0, width: 5, height: 1))
		projectile._tower = fromTower
		projectile._targetEnemy = targetEnemy
		projectile.setUp()
		projectile.position = fromTower.canonPosition
		return projectile
	}

	func setUp() {
		fillColor = .blackColor()
		strokeColor = .blackColor()
	}

	func update(dt: CFTimeInterval) {
		let delta = _targetEnemy.position - position
		let angle = atan2(delta.y, delta.x)

		let velocity: CGFloat = 600.0

		zRotation = angle

		position.x += cos(angle) * velocity * CGFloat(dt)
		position.y += sin(angle) * velocity * CGFloat(dt)
	}
}