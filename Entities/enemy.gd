class_name Enemy extends PathFollow3D

@onready var health : Health_Component = $Health_Component
@onready var wallet : Wallet = $Wallet

var moveSpeed = 5.0

func _ready() -> void:
	health.health_empty.connect(die)

func _physics_process(delta: float) -> void:
	progress += moveSpeed * delta

func die() -> void:
	pass
