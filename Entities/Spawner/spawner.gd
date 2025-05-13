class_name Spawner extends Node3D

@onready var waveBufferTimer : Timer = $WaveBufferTimer
@export var levelPath : Path3D
@export var waveInfoList : Array[WaveInfo]
var curWaveNumber : int = 0
var curWave : WaveInfo
var curWaveTimer : float = 0.0
var numberOfEnemies : int = 0


func _ready() -> void:
	# debug start wave
	await get_tree().create_timer(1.0).timeout
	advance_wave()

func _physics_process(delta: float) -> void:
	if curWave:
		curWaveTimer += delta
		curWave.process_call(delta, curWaveTimer)

func advance_wave() -> void:
	curWave = waveInfoList[curWaveNumber % waveInfoList.size()]
	curWaveTimer = 0.0
	for si in curWave.spawnInfoList:
		si.spawn_enemy.connect(spawn_enemy)
	# must be last
	curWaveNumber += 1


func end_wave() -> void:
	# curWave.waveCompletionReward
	waveBufferTimer.start()
	await waveBufferTimer.timeout
	advance_wave()

func spawn_enemy(enemy_scene : PackedScene) -> void:
	var newEnemy = enemy_scene.instantiate()
	# randomixe H & V Offset slightly
	newEnemy.h_offset = randf() - 0.5
	newEnemy.v_offset = randf() - 0.5
	# add enemy to scene
	levelPath.add_child(newEnemy)
	numberOfEnemies += 1

func enemy_died() -> void:
	# WARNING: flawed approuch. need some way of also checking that all spawnInfo's are done
	numberOfEnemies -= 1
	if numberOfEnemies <= 0:
		end_wave()
