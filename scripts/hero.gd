extends KinematicBody2D

export (int) var baseScore = 0

export (int) var attackMultiplyer = 5
export (float) var attackCoolDown = 2
export (PackedScene) var attackScn

var _canAttack

func _ready():
	pass
