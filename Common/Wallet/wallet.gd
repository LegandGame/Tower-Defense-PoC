class_name Wallet extends Node

@export var value : int
@export var maxValue : int = -1	#-1 = infinite

signal value_changed(new_value)
signal max_value_changed(new_max_value)

func _ready() -> void:
	clamp_value()

func clamp_value() -> void:
	if maxValue != -1:
		value = min(value, maxValue)

func get_value() -> int:
	return value
func get_max_value() -> int:
	return maxValue

func set_value(new_value : int) -> void:
	value = new_value
	clamp_value()
	value_changed.emit(value)
func set_max_value(new_value: int) -> void:
	maxValue = new_value
	clamp_value()
	max_value_changed.emit(maxValue)

func change_value(difference : int) -> void:
	value += difference
	clamp_value()
	value_changed.emit(value)
func change_max_value(difference : int) -> void:
	maxValue += difference
	clamp_value()
	max_value_changed.emit(maxValue)
