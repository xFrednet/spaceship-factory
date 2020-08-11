extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.info("Entered space scene", self)
	
	# TODO spawn meteoroids 
	
	pass # Replace with function body.

func _unhandled_key_input(event):
	if (Input.is_action_just_pressed("debug_spawn_meteoroid")):
		var met = load("res://entity/meteoroid/simple_meteoroid/simple_meteoroid.tscn").instance()
		met.set_position(Vector2(400, 64))
		$meteoroids.add_child(met)
	pass

func add_spaceship(spaceship : Spaceship) -> void:
	add_child(spaceship)

func get_logger_name() -> String:
	return "Space";
