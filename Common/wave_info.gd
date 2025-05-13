class_name WaveInfo extends Resource

@export var waveCompletionReward : int
@export var spawnInfoList : Array[SpawnInfo]
#var activeWave : bool = false
var spawnInfosCompleted : int = 0	#TODO

signal wave_complete	#TODO

#func _ready() -> void:
	#for si in spawnInfoList:
		#if activeWave:
			#si.set_process_mode(PROCESS_MODE_INHERIT)
		#else:
			#si.set_process_mode(PROCESS_MODE_DISABLED)

func process_call(delta : float, time_elapsed: float) -> void:
	for si in spawnInfoList:
		si.process_call(delta, time_elapsed)

#func activate_wave() -> void:
	#activeWave = true
	#for si in spawnInfoList:
		#si.set_process_mode(Node.PROCESS_MODE_INHERIT)
#
#func deactivate_wave() -> void:
	#activeWave = false
	#for si in spawnInfoList:
		#si.set_process_mode(Node.PROCESS_MODE_INHERIT)
