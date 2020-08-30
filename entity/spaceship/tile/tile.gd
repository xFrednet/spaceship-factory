extends StaticBody2D

class_name SfTile

export(String) var loot_table_entry : String = "sf:loot:tile.x"
export(String) var name_key : String = "t:"

func _init() -> void:
	set_collision_layer(CollisionStatic.SPACESHIP_LAYER)
	set_collision_mask(CollisionStatic.SPACESHIP_MASK)
	
	set_meta(ComponentStatic.HEALTH_COMPONENT, HealthComponent.new(self, 100.0))
	set_meta(ComponentStatic.METEOROID_COLLISION_COMPONENT, MeteoroidCollisionComponent.new(self, 0.5, 0.5))
	set_meta(ComponentStatic.DESTRUCTION_COMPONENT, DestructionComponent.new(self, loot_table_entry))
	ComponentStatic.call_create_links(self)

func _get_map() -> SfTileMap:
	return get_parent() as SfTileMap

func get_logger_name() -> String:
	return "Tile"
