extends StaticBody2D

class_name SfTile

export(String) var loot_table_entry : String = "loot:tile.x"
export(String) var name_key : String = "t:"

func _init() -> void:
	set_meta(ComponentStatic.HEALTH_COMPONENT, HealthComponent.new(self, 100.0))
	set_meta(ComponentStatic.METEOROID_COLLISION_COMPONENT, MeteoroidCollisionComponent.new(self, 0.5, 0.5))
	ComponentStatic.call_create_links(self)

func _get_map() -> SfTileMap:
	return get_parent() as SfTileMap

func get_logger_name() -> String:
	return "Tile"
