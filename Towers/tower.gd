class_name Tower extends Node3D

@onready var towerTop : MeshInstance3D = $TowerTop
@onready var muzzle : Marker3D = $TowerTop/Muzzle
@onready var attackTimer : Timer = $AttackTimer
@onready var rangeArea : Area3D = $RangeArea
@onready var rangeCollisionShape : CollisionShape3D = $RangeArea/CollisionShape3D

@export var bulletScene : PackedScene 

var enemyList : Array = []	# list of viable enemies in range

# STATS
var attackSpeed : float = 0.75	# seconds
var damage : int = 10
var range : float = 5.0			# meters
var aoe : float = 0.5			# meters
var projectile_speed : float
enum TARGET_TYPES {FIRST, LAST, CLOSE, FAR, STRONGEST, WEAKEST, RANDOM}
var targeting : TARGET_TYPES = TARGET_TYPES.FIRST


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attackTimer.set_wait_time(attackSpeed)
	attackTimer.timeout.connect(attack_timeout)
	rangeArea.body_entered.connect(on_range_body_entered)
	rangeArea.body_exited.connect(on_range_body_exited)
	rangeCollisionShape.shape.radius = range


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


func find_target() -> Node3D:
	return

func attack_timeout() -> void:
	# reset timer
	attackTimer.set_wait_time(attackSpeed)	#resseting wait timer in case attackSpeed is altered
	attackTimer.start()
	# attack
	var newBullet = bulletScene.instantiate()
	newBullet.position = muzzle.global_position
	newBullet.transform.basis = muzzle.global_transform.basis
	newBullet.transform.basis.z = -muzzle.global_transform.basis.z	# flip it around
	get_parent().add_child(newBullet)


func on_range_body_entered(body : Node3D) -> void:
	if body not in enemyList:
		enemyList.append(body)
func on_range_body_exited(body : Node3D) -> void:
	if body in enemyList:
		var i = enemyList.find(body)
		enemyList.pop_at(i)
