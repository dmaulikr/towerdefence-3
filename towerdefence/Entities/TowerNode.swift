//
//  Tower.swift
//  towerdefence
//
//  Created by Simon Andersson on 16/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation
import SpriteKit

protocol TowerProtocol {
	func tower(tower: TowerNode, fireProjectileAtTarget: EnemyNode)
	func tower(tower: TowerNode, canAffordUpgrade level: TowerLevel.Type) -> Bool
	func tower(tower: TowerNode, didUpgradeTo level: TowerLevel.Type)
}

class TowerNode: SKNode {

	private var _canon: TowerCanonNode!
	private var _base: TowerBaseNode!
	private var _target: EnemyNode?
	private var _fireInterval: Float = 0

	private lazy var _selectionNode: SKShapeNode = SKShapeNode()
	private lazy var _upgradeNode: UpgradeNode = UpgradeNode()

	private var _selected: Bool = false
	private var _enabled: Bool = true
	var enabled: Bool {
		set {
			_enabled = newValue
		}
		get {
			return _enabled
		}
	}

	var selected: Bool {
		set {
			_selected = newValue
			updateSelectionState()
		}
		get {
			return _selected
		}
	}

	private var _configuration: TowerLevel.Type!
	var configuration: TowerLevel.Type {
		return _configuration
	}

	private var _delegate: TowerProtocol?
	var delegate: TowerProtocol? {
		set {
			_delegate = newValue
		}
		get {
			return _delegate
		}
	}

	var canonPosition: CGPoint {
		get {
			let angle = _canon.zRotation
			var position = _canon.position
			position.x += cos(angle) * 20
			position.y += sin(angle) * 20
			return self.position + position
		}
	}

	class func create() -> TowerNode {
		let tower = TowerNode()
		tower.setUp()
		return tower
	}

	private func setUp() {
		_base = TowerBaseNode.create()
		_canon = TowerCanonNode.create()

		_configuration = TowerLevel1.self
		_fireInterval = _configuration.fireRate

		_base.upgrade(toLevel: _configuration)

		//userInteractionEnabled = true

		addChild(_base)
		addChild(_canon)
	}

	override init() {
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setUp()
	}

	func update(dt: CFTimeInterval) {
		_base.update(dt)
		_canon.update(dt)

		if let enemyTarget = _target where
			position.distance(enemyTarget.position) < _configuration.range
				&& enemyTarget.alive {
			let delta = enemyTarget.position - position
			let angle = atan2(delta.y, delta.x)

			// Normalize rotation
			if angle - _canon.zRotation > CGFloat(M_PI) {
				_canon.zRotation += 2.0 * CGFloat(M_PI)
			} else if _canon.zRotation - angle > CGFloat(M_PI) {
				_canon.zRotation -= 2.0 * CGFloat(M_PI)
			}

			_canon.zRotation += (angle - _canon.zRotation) * 0.1

			_fireInterval -= Float(dt)
			if _fireInterval <= 0 {
				// Fire
				_delegate?.tower(self, fireProjectileAtTarget: enemyTarget)
				_fireInterval = _configuration.fireRate
			}

		}
		else {
			// Ideling
			_canon.zRotation += -0.1 * CGFloat(dt)
		}
	}

	func nextLevel(currentTowerLevel: TowerLevel.Type) -> TowerLevel.Type? {
		if let idx = TowerLevels.indexOf({ return currentTowerLevel == $0 })
			where idx < TowerLevels.count - 1 {
			return TowerLevels[idx + 1]
		}
		return nil
	}

	func target(enemyTarget: EnemyNode?) {
		_target = enemyTarget
	}

	private func updateSelectionState() {
		if let nextTowerLevel = nextLevel(_configuration) where _selected {
			_upgradeNode.levelText = nextTowerLevel.name
			_upgradeNode.priceText = "$\(nextTowerLevel.price)"
			_upgradeNode.position.y = 20
			if _upgradeNode.parent == nil {
				addChild(_upgradeNode)
			}
		}
		else if _upgradeNode.parent != nil {
			_upgradeNode.removeFromParent()
		}

		let pattern: [CGFloat] = [5.0, 10.0]

		let circlePath = CGPathCreateMutable()
		CGPathAddArc(circlePath, nil, position.x, position.y, _configuration.range, 0, CGFloat(M_PI) * 2, true)

		let path = CGPathCreateCopyByDashingPath(circlePath, nil, 0, pattern, 2)
		
		_selectionNode.path = path
		_selectionNode.fillColor = .clearColor()
		_selectionNode.strokeColor = .whiteColor()


		if let parent = parent
			where _selected && _selectionNode.parent == nil {
			parent.addChild(_selectionNode)
		}
		else if !_selected {
			_selectionNode.removeFromParent()
		}
	}
}

extension TowerNode {
	func touchBegan(point: CGPoint) -> Bool {
		if !_enabled {
			return false
		}

		self.selected = true

		let nodes = parent!.nodesAtPoint(point).filter {
			$0 is UpgradeNode
		}

		if let _ = nodes.first,
			let nextConf = nextLevel(_configuration) where
			_delegate!.tower(self, canAffordUpgrade: nextConf) {
			_delegate?.tower(self, didUpgradeTo: nextConf)
			_configuration = nextConf
			_base.upgrade(toLevel: _configuration)
			updateSelectionState()
			return true
		}
		
		return false
	}
}
