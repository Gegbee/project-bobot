extends Node2D

export var _name : String = ""
export(String, FILE, "*.tscn") var entered_scene_path = ""
export var sprite : Texture = null

#var entered_scene = null
func _ready():
#	$Label.rect_pivot_offset.x = $Label.rect_size.x/2
#	$Label.rect_pivot_offset.y = $Label.rect_size.y/2
	$Label.modulate = Color(1, 1, 1, 0)
	$Sprite.texture = sprite
	if _name != "":
		$Label.text = _name
	else:
		$Label.text = "No name"
	$Label.rect_position.x = -$Label.rect_size.x
#	entered_scene = Preloads.underworlds[entered_scene_path]
	
func _process(delta):
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group('player'):
			body.in_entrance_area = self
	pass
	
func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		body.in_entrance_area = self
		$Tween.interpolate_property($Sprite, "scale", $Sprite.scale, Vector2(1.4, 1.4), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Tween.interpolate_property($Label, "modulate", $Label.modulate, Color(1, 1, 1, 1), 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
		#$Tween.interpolate_property($Sprite, "rotation", $Sprite.rotation, PI/12, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Tween.start()
	
func _on_Area2D_body_exited(body):
	if body.is_in_group('player'):
		$Tween.interpolate_property($Sprite, "scale", $Sprite.scale, Vector2(1, 1), 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Tween.interpolate_property($Label, "modulate", $Label.modulate, Color(1, 1, 1, 0), 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
		#$Tween.interpolate_property($Sprite, "rotation", $Sprite.rotation, 0, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Tween.start()
		if body.in_entrance_area == self:
			body.in_entrance_area = null
