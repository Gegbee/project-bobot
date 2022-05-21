extends Node2D

export(String, FILE, "*.tscn") var entered_scene_path = ""
export var sprite : Texture = null

#var entered_scene = null
func _ready():
	$Sprite.texture = sprite
#	entered_scene = Preloads.underworlds[entered_scene_path]
	
func _process(delta):
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group('player'):
			if Input.is_action_pressed("enter"):
				get_tree().change_scene(entered_scene_path)

func _on_Area2D_body_entered(body):
	$Tween.interpolate_property($Sprite, "scale", $Sprite.scale, Vector2(1.4, 1.4), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property($Sprite, "rotation", $Sprite.rotation, PI/12, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	
func _on_Area2D_body_exited(body):
	$Tween.interpolate_property($Sprite, "scale", $Sprite.scale, Vector2(1, 1), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property($Sprite, "rotation", $Sprite.rotation, 0, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
