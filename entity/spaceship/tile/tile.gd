extends StaticBody2D

class_name SfTile

var health : float = 1.0
export(float, 10.0, 10000.0) var max_health : float = 10.0
export(String) var loot_table_entry : String = "loot:tile.x"
export(String) var name_key : String = "t:"

func _ready():
	health = max_health
	pass # Replace with function body.

func _on_meteoroid_collision(other: Node, force : Vector2) -> void:
	if self.is_queued_for_deletion():
		return
	
	var damage = force.length()
	self.deal_damage(damage)
	other.deal_damage(damage / 2)

func deal_damage(damage: float) -> void:
	health -= damage
	if (health <= 0.0):
		_destruction()

func _destruction() -> void:
	
	# TODO frist 11.08.2020: Drop ressources on destcruction #34
	
	get_parent().remove_child(self)
	self.queue_free()

func _get_map() -> SfTileMap:
	return get_parent() as SfTileMap

func get_logger_name() -> String:
	return "Tile"
