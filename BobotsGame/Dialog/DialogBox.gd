extends Control

enum {
	NONE,
	RUNNING,
	IDLE
}
var state : int = NONE
onready var t = $CenterContainer/Label

func runDialog(new_dialog : String):
	t.percent_visible = 0
	t.text = new_dialog
	$Tween.interpolate_property(t, "percent_visible", 0, 1, 
	float(len(t)) / 40.0, 
	Tween.TRANS_LINEAR, 
	Tween.EASE_OUT)
	$Tween.start()
	
func finishRunningDialog():
	$Tween.reset_all()
	$Tween.remove_all()
	t.percent_visible = 1
	
func nextAction():
	if state == RUNNING:
		finishRunningDialog()
	elif state == IDLE:
		pass
	elif state == NONE:
		pass
