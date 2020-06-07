extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.info("Entered space scene", self)
	
	# TODO spawn meteoroids 
	
	pass # Replace with function body.

func add_spaceship(spaceship : Spaceship) -> void:
	add_child(spaceship)

func get_logger_name() -> String:
	return "Space";
