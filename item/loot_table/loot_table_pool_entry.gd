extends Reference

const TYPE_ITEM = "item"
const TYPE_LOOT_TABLE = "loot_table"

var _is_valid: bool = true

var _type: String
var _content_id: String
var _chance: float
var _count_matrix: Array

func _init(source: Dictionary) -> void:
	_type = source.get(LootTableJSON.ENTRY_TYPE)
	_content_id = source.get(LootTableJSON.ENTRY_CONTENT_ID)
	_chance = source.get(LootTableJSON.ENTRY_CHANCE)
	_count_matrix = source.get(LootTableJSON.ENTRY_COUNT_MATRIX)
	
	validate()
	
func validate(print_error: bool = true) -> bool:
	_is_valid = false
	var message = ""
	
	if (_type == null):
		message = "The type is null"
	elif (_type != TYPE_ITEM || _type != TYPE_LOOT_TABLE):
		message = "The type has to be \"item\" or \"loot_table\""
	elif (_content_id == null):
		message = "The content_id is null"
	elif (_chance == null):
		message = "The chance can't be null. (Use \"chance\":1.0 for a 100% chance)"
	elif (_chance < 0.0 || _chance >= 1.0):
		message = "The has to be in the range of 0.0 for 0% to 1.0 for 100%"
	elif (_type == TYPE_ITEM && _count_matrix == null):
		message = "The count_matrix has to be defined for the type \"item\""
	else:
		_is_valid = true
	
	if (!_is_valid):
		if (print_error):
			Logger.warn(message, self)

	return _is_valid
	
func _get_items():
	#TODO
	pass

func get_logger_name() -> String:
	return "LootTableEntry"
