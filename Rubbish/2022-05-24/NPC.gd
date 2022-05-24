extends Node2D

export var _name : String = "No name"
export var sprite_frames : Texture = null

export (Array, String) var lines = ["First line"]

func _ready():
	$AnimatedSprite.frames = SpriteFrames.new()
	$AnimatedSprite.frames.add_animation("idle")
	$AnimatedSprite.frames.add_frame("idle", sprite_frames, 0)
	$AnimatedSprite.frames.add_frame("idle", sprite_frames, 1)
	$AnimatedSprite.frames.add_frame("idle", sprite_frames, 2)
	$Label.modulate = Color(1, 1, 1, 0)
	$Label.rect_position.x = -$Label.rect_size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
