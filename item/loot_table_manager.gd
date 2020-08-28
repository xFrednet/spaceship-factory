extends Node

const ENTRY_TYPE_ITEM = "item"
const ENTRY_TYPE_LOOT_TABLE = "loot_table"

const DEFAULT_FILE = "res://resource_pack/spaceship_factory/loot_tables.json"
const DEFAULT_NAMESPACE = "sf"

var _loot_tables = {}

func _ready():
	load_loot_tables(DEFAULT_NAMESPACE, DEFAULT_FILE)
	Logger.info("Init() is done", self)

func load_loot_tables(namespace : String, file_path : String):
	var file = File.new()
	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	
	var obj = JSON.parse(content)
	if (obj.error != OK):
		Logger.error(obj.error_string, self)
		return
	
	var loot_tables = obj.result[LootTableJSON.ROOT_NAME]
	_validate_loot_tables(loot_tables)
	
	_loot_tables[namespace] = loot_tables

func _validate_loot_tables(obj) -> bool:
	
	if !(obj is Dictionary):
		Logger.error("The object to validate must be a dictionary", self)
		return false
	
	for loot_table_name in obj.keys():
		var loot_table = obj[loot_table_name]
		if !(loot_table is Array):
			Logger.error("The loot_table %s is not an array" % loot_table_name, self)
			return false
		
		for pool_index in range(0, loot_table.size()):
			var pool = loot_table[pool_index]
			if !_validate_loot_table_pool(pool, loot_table_name, pool_index):
				# The error get's reported by the validate method in the if
				return false
		
	
	return true

func _validate_loot_table_pool(pool, loot_table_name: String, pool_index: int) -> bool:
	# Type
	if !(pool is Dictionary):
		Logger.error("%s[%d]: The pool must be a dictionary" % [loot_table_name, pool_index], self)
		return false
	
	# Name
	if !pool.has(LootTableJSON.POOL_NAME):
		Logger.error("%s[%d]: The pool must have a 'name' entry" % [loot_table_name, pool_index], self)
		return false
	var pool_name = loot_table_name + "." + pool[LootTableJSON.POOL_NAME]
	
	# Entries
	if !pool.has(LootTableJSON.POOL_ENTRIES):
		Logger.error("%s: The pool must have a 'entries' entry" % [pool_name], self)
		return false
	var entries = pool[LootTableJSON.POOL_ENTRIES]
	for entry_index in range(0, entries.size()):
		var entry = entries[entry_index]
		if !_validate_loot_table_pool_entry(entry, pool_name, entry_index):
			# The error get's reported by the validate method in the if
			return false
	
	return true

func _validate_loot_table_pool_entry(entry, pool_name, entry_index):
	var is_valid = false
	var message = ""
	
	# This is some high quality unreadable code ^^
	if !(entry is Dictionary):
		message = "The entry type is wrong"
	elif !(entry.has(LootTableJSON.ENTRY_TYPE)):
		message = "The type is null"
	elif (entry[LootTableJSON.ENTRY_TYPE] != ENTRY_TYPE_ITEM && 
			entry[LootTableJSON.ENTRY_TYPE] != ENTRY_TYPE_LOOT_TABLE):
		message = "The type has to be \"item\" or \"loot_table\""
	elif !(entry.has(LootTableJSON.ENTRY_CONTENT_ID)):
		message = "The content_id is null"
	elif !(entry.has(LootTableJSON.ENTRY_CHANCE)):
		message = "The chance can't be null. (Use \"chance\":1.0 for a 100% chance)"
	elif (entry[LootTableJSON.ENTRY_CHANCE] < 0.0 ||
			entry[LootTableJSON.ENTRY_CHANCE] > 1.0):
		message = "The has to be in the range of 0.0 for 0% to 1.0 for 100%"
	elif (entry[LootTableJSON.ENTRY_TYPE] == ENTRY_TYPE_ITEM &&
			!(entry.has(LootTableJSON.ENTRY_COUNT_MATRIX))):
		message = "The count_matrix has to be defined for the type \"item\""
	else:
		is_valid = true
	
	if (!is_valid):
		Logger.error("%s[%d]: %s" % [pool_name, entry_index, message], self)
	
	return is_valid

func get_logger_name() -> String:
	return "LootTableManager"
