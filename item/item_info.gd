extends Resource

class_name ItemInfo

const INFO_STRING_PART_COUNT = 3
const TEXTURE_ROOT_FOLDER = "res://item/texture/%s"

export var _item_id : String
export(float, 0.001, 20, 0.2) var _item_weight : float;
export var _item_image : Texture = null

func _init(info_string):
	if info_string != null:
		_parse_info_string(info_string)

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

################
# Util
################
func can_stack(other) -> bool:
	return _item_id == other.get_id()

################
# Internals
################
func _parse_info_string(info_string):
	var parts = info_string.split(",")
	
	if parts.size() != INFO_STRING_PART_COUNT:
		Logger.error("The info string has the wrong part count: \"%s\"" % info_string, self)
		return
	
	_item_id = parts[0].strip_edges()
	_item_weight = parts[1].to_float()
	_item_image = load(TEXTURE_ROOT_FOLDER % parts[2].strip_edges())
	
	if _item_image == null:
		Logger.warn("Unable to load the texture for the item: %s" % _item_id, self)
		_item_id = ""
		return
	else:
		Logger.debug(
			"Loaded %-16s [weight: %5.3f, texture: %s]" %
				[_item_id, _item_weight, parts[2].strip_edges()], 
			self)

func get_logger_name() -> String:
	return "ItemInfo";
