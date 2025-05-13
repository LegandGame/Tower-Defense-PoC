class_name SpawnInfo extends Resource

@export var enemyScene : PackedScene
@export var startTime : float
@export var endTime : float
@export var spawnFrequency : float

var timeBetweenSpawns := spawnFrequency

signal spawn_enemy(enemy_scene)
signal complete
var completeSignalEmitted : bool = false

func process_call(delta : float, time_elapsed: float) -> void:
	if time_elapsed >= startTime and time_elapsed <= endTime:
		timeBetweenSpawns += delta
		if timeBetweenSpawns >= spawnFrequency:
			spawn_enemy.emit(enemyScene)
			timeBetweenSpawns = 0.0
	# feels kinda scuffed but best I can come up with now
	elif time_elapsed > endTime and !completeSignalEmitted:
		complete.emit()
		completeSignalEmitted = true
