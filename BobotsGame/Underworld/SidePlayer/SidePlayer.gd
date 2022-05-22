extends KinematicBody2D

const SPEED = 50
const ACCEL = 30
const JUMP_SPEED = 110
const GRAVITY = 300

const CAT_TIME = 0.4
var can_jump := false
var num_of_jumps : int = 0
const MAX_JUMPS : int = 1

var vel : Vector2 = Vector2()

func _ready():
	add_to_group('player')
	
func _physics_process(delta):
	var dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if is_on_floor():
		can_jump = true
		num_of_jumps = 0
	else:
		vel.y += GRAVITY * delta
	if can_jump:
		if dir.x:
			vel.x += dir.x * ACCEL
			vel.x = clamp(vel.x, -SPEED, SPEED)
		else:
			vel.x = lerp(vel.x, 0, 0.4)
		if Input.is_action_just_pressed("jump") and num_of_jumps < MAX_JUMPS:
			num_of_jumps += 1
			$Timer.start(CAT_TIME)
			vel.y = -JUMP_SPEED
#	elif is_on_wall():
#		vel.y = 0
#		if Input.is_action_just_pressed("jump"):
#			vel.y = -JUMP_SPEED
	else:
		vel.x = lerp(vel.x, 0, 0.02)
	vel = move_and_slide(vel, Vector2.UP, false, 4, PI/4, false)



func _on_Timer_timeout():
	can_jump = false
