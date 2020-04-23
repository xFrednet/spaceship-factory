extends StaticBody2D

class_name SfTile

func _ready():
	Logger.info("Hello", self);
	pass # Replace with function body.

func _get_map() -> SfTileMap:
	return get_parent() as SfTileMap

func get_logger_name() -> String:
	return "Tile"
