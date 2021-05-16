extends KinematicBody2D

onready var flashArea = $Area2D
onready var flashTimer = $Area2D/FlashTimer
onready var flashAnimationPlayer = $Area2D/AnimationPlayer

export(int) var speed = 400

var velocity = Vector2.ZERO


var can_shoot = true

func _ready():
	pass
	
func _input(event):
	handleMovement()
	look_at(get_global_mouse_position())	
	if event is InputEventMouseButton and can_shoot:
		takePicture()
		


func takePicture() -> void:
	flashAnimationPlayer.play("flash")
	can_shoot = false
	flashTimer.start()
	
	var bodies = $Area2D.get_overlapping_bodies()
	var scoreShotTotal = 0
	for b in bodies:
		scoreShotTotal += b.scoreBase
	print(scoreShotTotal)

func handleMovement():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	move_and_slide(velocity)


func _on_FlashTimer_timeout():
	can_shoot = true
