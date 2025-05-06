class_name Tower extends Node3D

@onready var towerTop : MeshInstance3D = $TowerTop
@onready var muzzle : Marker3D = $TowerTop/Muzzle
@onready var attackTimer : Timer = $AttackTimer

@export var bulletScene : PackedScene

var attackSpeed : float = 0.75	# seconds
var damage : int = 10
var range : float = 5.0			# meters
var aoe : float = 0.5			# meters

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attackTimer.set_wait_time(attackSpeed)
	attackTimer.timeout.connect(attack_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	turn()

func turn() -> void:
	# TEMP
	var targetPlaneMouse = Plane(Vector3(0, 1, 0), position.y)
	var enemyPos = get_viewport().get_mouse_position()
	var camera : Camera3D = get_parent_node_3d().get_parent_node_3d().get_node("Camera3D")
	var from = camera.project_ray_origin(enemyPos)
	var to = from + camera.project_ray_normal(enemyPos) * 1000
	var mousePosPlane = targetPlaneMouse.intersects_ray(from, to)
	
	towerTop.look_at(mousePosPlane, Vector3.UP, true)
	towerTop.rotation = Vector3(0, towerTop.rotation.y, 0)


func attack_timeout() -> void:
	# reset timer
	attackTimer.set_wait_time(attackSpeed)
	attackTimer.start()
	# attack
