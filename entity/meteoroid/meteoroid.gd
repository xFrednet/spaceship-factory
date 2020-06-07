extends RigidBody2D

class_name Meteoroid

var health : float = 1.0
export(float, 10, 1, 0.1) var max_health : float = 1.0
export(String, "loot:meteoroid.x") var loot_table_entry : String

func _ready():
	health = max_health
	pass

func get_max_health() -> float:
	return max_health

func get_health() -> float:
	return health

func get_loot_table_key() -> String:
	return loot_table_entry
