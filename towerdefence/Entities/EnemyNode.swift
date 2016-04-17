//
//  EnemyNode.swift
//  towerdefence
//
//  Created by Simon Andersson on 16/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation
import SpriteKit

protocol EnemyProtocol {
	func enemy(didDie enemy: EnemyNode)
	func enemy(didReachEnd enemy: EnemyNode)
}

class EnemyNode: SKShapeNode {
	private var _currentWaypointIndex: Int = 0
	private var _configuration: EnemyConfiguration!
	var configuration: EnemyConfiguration {
		return _configuration
	}

	private var _delegate: EnemyProtocol?
	var delegate: EnemyProtocol? {
		set {
			_delegate = newValue
		}
		get {
			return _delegate
		}
	}

	private var _waypoints: [CGPoint]?
	var waypoints: [CGPoint]? {
		set {
			_waypoints = newValue
			updateInitialPosition()
		}
		get {
			return _waypoints
		}
	}

	private var _alive: Bool {
		return _health > 0
	}

	var alive: Bool {
		return _alive
	}

	private var _health: Float = 0

	private var _velocity: CGPoint = CGPoint(x: 60, y: 60)

	class func create(conf: EnemyConfiguration.Type) -> EnemyNode {
		let enemy = EnemyNode(circleOfRadius: 8)
		enemy._configuration = conf.init()
		enemy.setUp()
		return enemy
	}

	private func setUp() {
		_health = _configuration.health
		fillColor = .whiteColor()
		strokeColor = .whiteColor()
	}

	override init() {
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func updateInitialPosition() {
		guard let firstPoint = _waypoints?.first else {
			return
		}

		position = firstPoint
	}

	func takeDamage(fromTower tower: TowerNode) {
		_health = _health - tower.configuration.damage
		if _health <= 0 {
			_delegate?.enemy(didDie:self)
		}
	}

	func update(dt: CFTimeInterval) {
		guard let waypoints = _waypoints where _alive else {
			return;
		}

		if _currentWaypointIndex + 1 >= waypoints.count {
			_health = 0
			_delegate?.enemy(didReachEnd: self)
			return
		}

		let nextWaypoint = waypoints[_currentWaypointIndex + 1]

		let distance = position.distance(nextWaypoint)

		let delta = nextWaypoint - position
		let angle = atan2(delta.y, delta.x)

		position.x += cos(angle) * _configuration.velocity * CGFloat(dt)
		position.y += sin(angle) * _configuration.velocity * CGFloat(dt)

		if distance < 1.0 {
			_currentWaypointIndex += 1
		}
	}
}