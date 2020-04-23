extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.info("Entered station class", self)
	pass # Replace with function body.


func get_logger_name() -> String:
	return "Station";
