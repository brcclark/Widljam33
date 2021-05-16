extends "res://scripts/enemy.gd"

onready var idleTimer = $IdleTimer

export (int) var rotation_speed = 2
export (int) var maxMoveSpeed = 100


var _target
var velocity = Vector2.ZERO

var _rot = 0
export (float) var _minidleTime = 2
export (float) var _maxIdleTime = 6


func _ready():
	idleTimer.start()
	_rot = rand_range(-180,180)
	rotation_degrees = _rot	
	idleTimer.wait_time = rand_range(_minidleTime,_maxIdleTime)

func _physics_process(delta):
	
	if _target:
		idleTimer.stop()
		chase_target()
	else:
		rotation_degrees = lerp(rotation_degrees,_rot,rotation_speed * delta) 
		velocity = Vector2.ZERO

func rotate_random() -> void:
	#Get a random new rotation
	_rot = rand_range(rotation_degrees-180.0,rotation_degrees+180.0)	
		

func chase_target():
	velocity = (_target.position - position).normalized() * maxMoveSpeed
	look_at(_target.position)
	move_and_slide(velocity)


func _on_IdleTimer_timeout():
	rotate_random()
	idleTimer.start()

 
func _on_Area2D_body_entered(body):
	if _target == null:
		_target = body


func _on_Area2D_body_exited(body):
	_target = null
	idleTimer.start()

