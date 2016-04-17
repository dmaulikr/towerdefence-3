//
//  Phase.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation

protocol Phase {
	var numberOfEnemies: Int { get }
	var numberOfWaves: Int { get }
	var configurations: [EnemyConfiguration.Type] { get }
	var spawnRate: Float { get }
}

struct Wave1: Phase {
	var numberOfWaves: Int {
		return 1
	}

	var numberOfEnemies: Int {
		return 10
	}

	var configurations: [EnemyConfiguration.Type] {
		return [BasicEnemy.self]
	}

	var spawnRate: Float {
		return 1.5
	}
}

struct Wave2: Phase {
	var numberOfWaves: Int {
		return 2
	}

	var numberOfEnemies: Int {
		return 30
	}

	var configurations: [EnemyConfiguration.Type] {
		return [BasicEnemy.self, MediumEnemy.self]
	}

	var spawnRate: Float {
		return 0.85
	}
}

struct Wave3: Phase {
	var numberOfWaves: Int {
		return 2
	}

	var numberOfEnemies: Int {
		return 10
	}

	var configurations: [EnemyConfiguration.Type] {
		return [MediumEnemy.self, MediumEnemy.self]
	}

	var spawnRate: Float {
		return 0.85
	}
}

struct Wave4: Phase {
	var numberOfWaves: Int {
		return 1
	}

	var numberOfEnemies: Int {
		return 5
	}

	var configurations: [EnemyConfiguration.Type] {
		return [HardEnemy.self]
	}

	var spawnRate: Float {
		return 1.0
	}
}