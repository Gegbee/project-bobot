extends KinematicBody2D

const SPEED = 60

var in_entrance_area = null

func _ready():
	add_to_group('player')
	
func _physics_process(delta):
	var dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	move_and_slide(dir * SPEED)

func _process(delta):
	print(in_entrance_area)
	if in_entrance_area != null:
		if Input.is_action_pressed("enter"):
			get_tree().change_scene(in_entrance_area.entered_scene_path)
