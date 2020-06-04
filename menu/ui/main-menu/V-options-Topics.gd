extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_optionsbutton_pressed():
	set_visible(!
	visible)
	pass # Replace with function body.



func _on_Continuebutton_pressed():
	set_visible(0)
	pass # Replace with function body.


func _on_NewLoadGamebutton_pressed():
	set_visible(0)
	pass # Replace with function body.


func _on_statisticsbutton_pressed():
	set_visible(0)
	pass # Replace with function body.


func _on_quitbutton_pressed():
	set_visible(0)
	pass # Replace with function body.
