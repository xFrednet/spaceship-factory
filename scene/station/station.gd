extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.info("Entered station scene", self)
	pass # Replace with function body.

func add_spaceship(spaceship : Spaceship) -> void:
	add_child(spaceship)

func get_logger_name() -> String:
	return "Station";
