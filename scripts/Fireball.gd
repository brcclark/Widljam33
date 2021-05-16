extends Area2D

class_name Fireball

signal HitObject

export (float) var baseDamage = 1
export (float) var maxSpeed = 300
export (float) var liveTime = 2

onready var lifeTimer = $LifetimeTimer

var _velocity = Vector2.ZERO
var _dmgMultiplyer = 1

func start(_pos, _dir, _dmgMult = 1):
	_dmgMultiplyer = _dmgMult
	position = _pos
	rotation = _dir.angle()
	_velocity = _dir * maxSpeed
	lifeTimer.wait_time = liveTime

func _process(delta):
	position += _velocity * delta

func explode() -> void:
	queue_free()

func _on_Fireball_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(baseDamage * _dmgMultiplyer)
	explode()
	print("boomshakalaka")

func _on_LifetimeTimer_timeout():
	print("timeout")
	explode()
