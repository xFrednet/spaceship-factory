extends Node

const CLIENT_ENTRY_SCENE = "res://scene/scene_manager.tscn"

func _ready():
	Logger.info("Entered entry scene", self)
	var _x = get_tree().change_scene(self.CLIENT_ENTRY_SCENE);

func get_logger_name() -> String:
	return "Le_Game";
