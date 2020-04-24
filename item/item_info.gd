extends Resource

class_name ItemInfo

export var _item_id : String
export(float, 0.001, 20, 0.2) var _item_weight : float;
export var _item_image : Texture = null

func get_id() -> String:
	return _item_id

func get_name() -> String:
	return _item_id + ".name"

func get_description() -> String:
	return _item_id + ".description"

func get_weight() -> float:
	return _item_weight

func get_texture() -> Texture:
	return _item_image
