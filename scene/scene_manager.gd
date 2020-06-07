extends Node

onready var scene_list = {
	"station": load("res://scene/station/station.tscn").instance(),
	"space": load("res://scene/space/space.tscn").instance()
}

onready var keys = ["station", "space"]
var key_index = 1

func _ready() -> void:
	add_child(scene_list.get("station"))
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap_scene"):
		print(get_child_count())
		var scene = get_child(0)
		remove_child(scene) # The scene instance is keep by the scene_list
		
		var spaceship = GameData.spaceship
		spaceship.get_parent().remove_child(spaceship)
		
		var new_scene = scene_list.get(keys[key_index])
		key_index = (key_index + 1) % keys.size()
		new_scene.add_spaceship(spaceship)
		add_child(new_scene)

func get_logger_name() -> String:
	return "SceneMgr";
