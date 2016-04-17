//
//  PhaseManager.swift
//  towerdefence
//
//  Created by Simon Andersson on 17/04/16.
//  Copyright © 2016 Hiddencode.me. All rights reserved.
//

import Foundation
import SpriteKit

protocol PhaseManagerDelegate {
	func phaseManager(shouldSpawnEnemy phaseManager: PhaseManager, withConfiguration conf: EnemyConfiguration.Type)
	func phaseManager(prepareForNextWave phaseManager: PhaseManager)
	func phaseManager(prepareForNextPhase phaseManager: PhaseManager)
	func phaseManager(didStart phaseManager: PhaseManager)
	func phaseManager(didEnd phaseManager: PhaseManager)
	func phaseManager(numberOfEnemiesAlive phaseManager: PhaseManager) -> Int
}

class PhaseManager {

	private let _phases: [Phase]
	private var _currentPhaseIndex: Int = 0
	private var _running: Bool = false

	private var _spawnTimer: Float = 0.0
	private var _numberOfSpawnedEnemies: Int = 0
	private var _currentWave: Int = 0

	private var _delegate: PhaseManagerDelegate?
	var delegate: PhaseManagerDelegate? {
		set {
			_delegate = newValue
		}
		get {
			return _delegate
		}
	}

	init(phases: [Phase]) {
		_phases = phases
	}

	func start() {
		_running = true
		_delegate?.phaseManager(didStart: self)
		_spawnTimer = -5.0
	}

	func stop() {
		_running = false
	}

	func update(dt: CFTimeInterval) {
		if !_running {
			return
		}

		if _currentPhaseIndex >= _phases.count {
			_running = false
			_delegate?.phaseManager(didEnd: self)
			return
		}

		guard let phase: Phase = _phases[_currentPhaseIndex] else {
			return
		}

		_spawnTimer += Float(dt)

		if _spawnTimer >= phase.spawnRate
			&& _numberOfSpawnedEnemies < phase.numberOfEnemies / phase.numberOfWaves
			&& _currentWave < phase.numberOfWaves {
			_spawnTimer = 0.0
			_numberOfSpawnedEnemies += 1
			_delegate?.phaseManager(shouldSpawnEnemy: self, withConfiguration: phase.configurations[_currentWave])
		}

		if _numberOfSpawnedEnemies == phase.numberOfEnemies / phase.numberOfWaves
			&& _currentWave < phase.numberOfWaves {
			_currentWave += 1
			_spawnTimer = -5.0

			if _currentWave < phase.numberOfWaves && _delegate?.phaseManager(numberOfEnemiesAlive: self) == 0 {
				_numberOfSpawnedEnemies = 0
				_delegate?.phaseManager(prepareForNextWave: self)
			}
		}

		if _currentWave == phase.numberOfWaves && _delegate?.phaseManager(numberOfEnemiesAlive: self) == 0 {
			_currentPhaseIndex += 1
			_currentWave = 0
			_numberOfSpawnedEnemies = 0
			_spawnTimer = -10.0

			if _currentPhaseIndex < _phases.count {
				_delegate?.phaseManager(prepareForNextPhase: self)
			}
		}
	}
}