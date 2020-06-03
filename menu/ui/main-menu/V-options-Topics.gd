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

##following a test that schall not pass the final
#func _on_optionsbutton_button_down():
#	set_visible(1) 
#	pass # Replace with function body.


#func _on_optionsbutton_button_up():
#	set_visible(0)
#	pass # Replace with function body.
func if():
	_on_optionsbutton_toggled(button_pressed):
	set_visible(1)
	else()
	set_visible(0)
	break
	pass # Replace with function body.



