extends RigidBody2D

class_name Meteoroid

var health : float = 1.0
export(float, 1.0, 1000.0) var max_health : float = 1.0
export(String) var loot_table_entry : String = "loot:meteoroid.x"
export(String) var name_key : String = "m:"

func _ready():
	health = max_health
	pass

func get_max_health() -> float:
	return max_health

func get_health() -> float:
	return health

func get_loot_table_key() -> String:
	return loot_table_entry
