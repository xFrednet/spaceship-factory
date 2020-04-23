extends Node

const CLIENT_ENTRY_SCENE = "res://scene/station/station.tscn"

func _ready():
	Logger.info("Entered entry scene", self)
	get_tree().change_scene(self.CLIENT_ENTRY_SCENE);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_logger_name() -> String:
	return "Le_Game";
