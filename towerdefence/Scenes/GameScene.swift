//
//  GameScene.swift
//  towerdefence
//
//  Created by Simon Andersson on 16/04/16.
//  Copyright (c) 2016 Hiddencode.me. All rights reserved.
//

import SpriteKit

#if os(OSX)
	import AppKit
#endif

class GameScene: SKScene {

	private var _money: Int = 250
	private var _draggingTower: TowerNode?
	private var _draggingPoint: CGPoint = .zero
	private var _groundLayer: GroundNode!
	private var _projectiles: [ProjectileNode] = []
	private var _enemies: [EnemyNode] = []
	private var _towers: [TowerNode] = []
	private var _addingTower: Bool = false
	private var _numberOfLives: Int = 3
	private lazy var _moneyLabel: SKLabelNode = SKLabelNode()

	private var _phaseManager: PhaseManager?

	private var _purchaseButton: PurchaseButtonNode!

	func waypoints() -> [CGPoint] {

		var paths: [CGPoint] = []

		paths.append(CGPoint(x: 0.5, y: 0))
		paths.append(CGPoint(x: 0.5, y: 0.2))
		paths.append(CGPoint(x: 0.3, y: 0.2))
		paths.append(CGPoint(x: 0.3, y: 0.55))
		paths.append(CGPoint(x: 0.8, y: 0.55))
		paths.append(CGPoint(x: 0.8, y: 0.70))
		paths.append(CGPoint(x: 0.5, y: 0.70))
		paths.append(CGPoint(x: 0.5, y: 1))

		return paths.reverse().map({ (pt) -> CGPoint in
			#if os(iOS)
				return pt * UIScreen.mainScreen().bounds.size
			#elseif os(OSX)
				return pt * view!.frame.size
			#endif
		})
	}

	override func didMoveToView(view: SKView) {
		backgroundColor = SKColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)

		let ground = Ground(points: waypoints())
		_groundLayer = GroundNode.create(ground)
		_groundLayer.ground = ground
		addChild(_groundLayer)

		_moneyLabel.horizontalAlignmentMode = .Left
		_moneyLabel.verticalAlignmentMode = .Top
		_moneyLabel.position.y = view.frame.size.height - 10
		_moneyLabel.position.x = 10
		_moneyLabel.fontName = "HelveticaNeueBold"
		_moneyLabel.fontSize = 16
		
		addChild(_moneyLabel)

		let phaseManager = PhaseManager(phases: [Wave1(), Wave2(), Wave3(), Wave4()])
		phaseManager.delegate = self
		_phaseManager = phaseManager
		
		_purchaseButton = PurchaseButtonNode.create()
		_purchaseButton.position.x = 32
		_purchaseButton.position.y = 32
		addChild(_purchaseButton)

		let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
		dispatch_after(delayTime, dispatch_get_main_queue()) {
			phaseManager.start()
		}
	}

	func sendMessage(text: String) {
		let label = SKLabelNode()
		label.text = text
		label.verticalAlignmentMode = .Top
		label.position.y = self.view!.frame.height - 100
		label.fontName = "HelveticaNeueBold"
		addChild(label)

		let labelWidth = label.calculateAccumulatedFrame().width

		let animation = SKAction.customActionWithDuration(2.5) { (node, time) in
			let progress = self.transitionEasing(time / 2.5)
			node.position.x = map(progress, in_min: 0, in_max: 1, out_min: -labelWidth/2.0, out_max: self.view!.frame.width + labelWidth/2.0)
			if progress == 1.0 {
				label.removeFromParent()
			}
			node.alpha = self.alphaEasing(progress)
		}

		label.runAction(animation)
	}

	func transitionEasing(x: CGFloat) -> CGFloat {
		let pi = CGFloat(M_PI)
		return pow(cos(pi + x * pi), 9.0) / 2.0 + 0.5
	}

	func alphaEasing(x: CGFloat) -> CGFloat {
		let pi = CGFloat(M_PI)
		return pow(cos(pi - x * pi), 10.0) / -1.0 + 1
	}

	func spawnEnemy(configuration: EnemyConfiguration.Type) {
		let enemy = EnemyNode.create(configuration)
		enemy.delegate = self
		enemy.waypoints = waypoints()
		_enemies.append(enemy)
		addChild(enemy)
	}

	private var _lastUpdateTimeInterval: NSTimeInterval = 0.0

	override func update(currentTime: NSTimeInterval) {
		var sinceLastTimeInterval = currentTime - _lastUpdateTimeInterval
		_lastUpdateTimeInterval = currentTime
		if sinceLastTimeInterval > 1.0 {
			sinceLastTimeInterval = 1.0 / 60.0
			_lastUpdateTimeInterval = sinceLastTimeInterval
		}

		let delta = sinceLastTimeInterval

		_towers.forEach { (tower) in
			tower.update(delta)

			var closesEnemy: EnemyNode? = nil
			_enemies.forEach({ (enemy) in
				if closesEnemy == nil {
					closesEnemy = enemy
				}
				else {
					if tower.position.distance(enemy.position) < tower.position.distance(closesEnemy!.position) {
						closesEnemy = enemy
					}
				}
			})

			tower.target(closesEnemy)
		}

		_enemies.forEach { (enemy) in
			enemy.update(delta)
		}

		_enemies = _enemies.flatMap {
			$0.alive ? $0 : nil
		}

		_projectiles.forEach { (projectile) in
			projectile.update(delta)

			if projectile.collides {
				projectile.alive = false
				projectile.targetEnemy.takeDamage(fromTower: projectile.tower)
				projectile.removeFromParent()
			}
		}

		if let phaseManager = _phaseManager {
			phaseManager.update(delta)
		}

		_moneyLabel.text = "💰 $\(_money)"

		_purchaseButton.alpha = _money >= TowerLevel1.price ? 1.0 : 0.3

		if let tower = _draggingTower where _addingTower {
			tower.position = tower.position + (_draggingPoint - _draggingTower!.position) * 0.5
		}
	}

	func addDraggingTower() {
		_addingTower = true
		_draggingTower = TowerNode.create()
		_draggingTower?.enabled = false


		addChild(_draggingTower!)
	}

	func addTowerAtPoint(pt: CGPoint) {
		let tower = TowerNode.create()
		tower.delegate = self
		tower.position = pt
		_towers.append(tower)

		_money -= tower.configuration.price

		addChild(tower)
	}
}

extension GameScene {
	func touchBegan(point: CGPoint) -> Bool {
		if let _ = nodesAtPoint(point)
			.filter({ $0 is PurchaseButtonNode })
			.first as? PurchaseButtonNode where _money >= TowerLevel1.price {
			addDraggingTower()
			_draggingPoint = point
			_draggingTower?.position = point
		}

		let nodes = nodesAtPoint(point).filter {
			$0 is TowerNode
		}

		_towers
			.filter({ $0.selected })
			.forEach({ $0.selected = false })

		if let tower = nodes.first as? TowerNode where tower.enabled {
			tower.selected = true
			tower.touchBegan(point)
			return true
		}
		return false
	}

	func touchEnded(point: CGPoint) {
		if let tower = _draggingTower where _addingTower {

			let point = tower.position

			addTowerAtPoint(point)

			tower.removeFromParent()
			_addingTower = false
			_draggingTower = nil
		}
	}

	func touchMoved(inout point: CGPoint) {
		if _addingTower {
			point.y += 40
			_draggingPoint = point
		}
	}
}

extension GameScene: TowerProtocol {
	func tower(tower: TowerNode, fireProjectileAtTarget: EnemyNode) {
		let projectile = ProjectileNode.create(tower, targetEnemy: fireProjectileAtTarget)
		self._projectiles.append(projectile)
		addChild(projectile)
	}

	func tower(tower: TowerNode, canAffordUpgrade level: TowerLevel.Type) -> Bool {
		return _money >= level.price
	}

	func tower(tower: TowerNode, didUpgradeTo level: TowerLevel.Type) {
		_money -= level.price
	}
}

extension GameScene: EnemyProtocol {

	func enemy(didReachEnd enemy: EnemyNode) {
		let action = SKAction.fadeOutWithDuration(0.5)
		enemy.runAction(action) {
			enemy.removeFromParent()
		}
		_numberOfLives -= 1
		if _numberOfLives == 0 {
			sendMessage("Game Over")

			_phaseManager?.stop()
			
			let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
			dispatch_after(delayTime, dispatch_get_main_queue()) {
				if let skView = self.view {
					let scene = MenuScene(size: skView.frame.size)
					scene.scaleMode = .AspectFill
					skView.presentScene(scene, transition: SKTransition.fadeWithDuration(1.0))
				}
			}
		}
	}

	func enemy(didDie enemy: EnemyNode) {

		_money += enemy.configuration.worth
		
		let action = SKAction.fadeOutWithDuration(0.5)
		enemy.runAction(action) { 
			enemy.removeFromParent()
		}
	}
}

extension GameScene: PhaseManagerDelegate {
	func phaseManager(shouldSpawnEnemy phaseManager: PhaseManager, withConfiguration conf: EnemyConfiguration.Type) {
		print("Should spawn enemy")
		spawnEnemy(conf)
	}

	func phaseManager(prepareForNextWave phaseManager: PhaseManager) {
		print("prepareForNextWave")
	}

	func phaseManager(prepareForNextPhase phaseManager: PhaseManager) {
		_money += 200

		sendMessage("Prepare for next phase")
	}

	func phaseManager(didStart phaseManager: PhaseManager) {
		print("didStart")

		sendMessage("Prepare your defences")
	}

	func phaseManager(didEnd phaseManager: PhaseManager) {
		print("didEnd")

		sendMessage("Game completed")
		_phaseManager?.stop()

		let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
		dispatch_after(delayTime, dispatch_get_main_queue()) {
			if let skView = self.view {
				let scene = MenuScene(size: skView.frame.size)
				scene.scaleMode = .AspectFill
				skView.presentScene(scene, transition: SKTransition.fadeWithDuration(1.0))
			}
		}
	}

	func phaseManager(numberOfEnemiesAlive phaseManager: PhaseManager) -> Int {
		return _enemies.count
	}
}
