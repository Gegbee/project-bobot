extends KinematicBody2D


export var can_dash : bool = true
export var can_slide : bool = true

const SPEED = 50
const ACCEL = 400
const JUMP_SPEED = 110
const GRAVITY = 300

const CAT_MAX_TIME = 0.5
var cat_jump_time : float= 0.0

var can_jump : bool = false

var vel : Vector2 = Vector2()

func _ready():
	add_to_group('player')
	
func _physics_process(delta):
	var dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	x_movement(delta, dir)

#	MOVING
#	if is_on_floor() or cat_jump:
#		if dir.x:
#			vel.x += dir.x * ACCEL * delta
#			vel.x = clamp(vel.x, -SPEED, SPEED)
#		else:
#			vel.x = lerp(vel.x, 0, 0.4)
#	else:
#		vel.x = lerp(vel.x, 0, 0.02)
#	SLIDING
#
#	if is_on_floor():
#		if can_slide and Input.is_action_just_pressed("crouch"):
#			vel.x += dir.x * ACCEL * delta * 8
#		if can_slide and Input.is_action_pressed("crouch"):
#			scale.y = 0.7
#			vel.x = lerp(vel.x, 0, 0.02)
#		else:
#			scale.y = 1
		
	#GRAVITY
	if len($Area2D.get_overlapping_bodies()) >= 1:
		can_jump = true
	else:
		can_jump = false
	if is_on_floor() or is_on_wall():
		cat_jump_time = 0.0
#		can_jump = true
	else:
		pass
#		cat_jump_time += delta
#		if CAT_MAX_TIME >= cat_jump_time:
#			can_jump = false
	vel.y += GRAVITY * delta
				
	#JUMPING
	if can_jump and Input.is_action_just_pressed("jump"):
		vel.y = -JUMP_SPEED
	
	vel = move_and_slide(vel, Vector2.UP, false, 4, PI/4, false)

func x_movement(delta, dir):
	if Input.is_action_pressed("crouch"):
		if is_on_floor():
			if can_slide:
				if Input.is_action_just_pressed("crouch"):
					vel.x *= 2
				vel.x = lerp(vel.x, 0, 0.02)
				scale.y = 0.7
	elif Input.is_action_just_pressed("dash"):
		scale.y = 1
	else:
		scale.y = 1
		if can_jump:
			if dir.x:
				vel.x += dir.x * ACCEL * delta
				vel.x = clamp(vel.x, -SPEED, SPEED)
			else:
				vel.x = lerp(vel.x, 0, 0.5)
		else:
			vel.x = lerp(vel.x, 0, 0.02)

