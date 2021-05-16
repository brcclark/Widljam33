extends "res://scripts/hero.gd"

#A hero that roams around and shoots fireballs at enemies

export (int) var wanderSpeed = 100
export (int) var moveSpeed = 300

export (int) var minWanderTime = 1
export (int) var maxWanderTime = 3
enum HeroState {IDLE, WANDER, CHASE_ENEMY, CHASE_PLAYER}

onready var wanderTimer = $WanderTimer

var _state = HeroState.IDLE
var _target = null

var _dest = Vector2.ZERO
var _velocity = Vector2.ZERO
var _can_attack = false

func _ready():
	_can_attack = true

func _process(delta):
	state_machine()
	if _target:
		attack()
func state_machine():
	match _state:
		HeroState.IDLE:
			if _target:
				pass
			else:
				if randf() < 0.5:
					_dest = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
				else:
					_dest = Vector2.ZERO
				wanderTimer.start(rand_range(minWanderTime,maxWanderTime))
				look_at(_dest)
				_state = HeroState.WANDER
			
		HeroState.WANDER:
			if _target:
				pass
			else:
				move_and_slide(_dest * wanderSpeed)
		HeroState.CHASE_PLAYER:
			pass
		HeroState.CHASE_ENEMY:
			pass

func attack() -> void:
	if _can_attack:
		print("attack!")
		_can_attack = false
		$AttackTimer.start()
		var a = attackScn.instance() as Fireball
		add_child(a)
		a.start(position,(_target.position - position).normalized())

func _on_WanderTimer_timeout():
	if _state == HeroState.WANDER:
		_state = HeroState.IDLE

func _on_EnemyDetect_body_entered(body):
	_target = body

func _on_AttackTimer_timeout():
	_can_attack = true
