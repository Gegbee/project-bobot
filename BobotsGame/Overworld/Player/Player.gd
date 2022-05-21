extends KinematicBody2D

const SPEED = 60

func _ready():
	add_to_group('player')
	
func _physics_process(delta):
	var dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	move_and_slide(dir * SPEED)
