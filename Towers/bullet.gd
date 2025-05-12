class_name Bullet extends Node3D

# REFERENCES
@onready var AreaOfEffect : Area3D = $AoEArea
@onready var AreaOfEffectCollider : CollisionShape3D = $AoEArea/CollisionShape3D

# stats
var speed = 5.0
var aoe = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AreaOfEffectCollider.shape.radius = aoe


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -speed) * delta


func _on_lifetime_timer_timeout() -> void:
	queue_free()
