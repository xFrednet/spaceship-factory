extends Node2D

class_name ItemEntitySpawner

export(String) var _item_id : String = ""
export(int, 1, 100) var _count : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	var item_stack = ItemStack.new(_item_id, _count)
	var item_entity = ItemEntity.new(item_stack)
	item_entity.set_position(self.get_position())
	item_entity.set_name(self.get_name())
	replace_by(item_entity)
