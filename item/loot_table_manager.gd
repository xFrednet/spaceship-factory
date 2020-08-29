extends Node

const MAX_LOOT_TABLE_ITERATIONS = 8

const ENTRY_TYPE_ITEM = "item"
const ENTRY_TYPE_LOOT_TABLE = "loot_table"

const DEFAULT_FILE = "res://resource_pack/spaceship_factory/loot_tables.json"
const DEFAULT_NAMESPACE = "sf"

var _loot_tables = {}

func _ready():
	load_loot_tables(DEFAULT_NAMESPACE, DEFAULT_FILE)
	Logger.info("Init() is done", self)

func get_loot_table_item_stacks(loot_table_id: String, iteration: int = 0) -> Array:
	if iteration >= MAX_LOOT_TABLE_ITERATIONS:
		return []
	
	var split = loot_table_id.split(":", true, 1)
	if split.size() != 2:
		Logger.warn("The loot_table '%s' has no namespace" % [loot_table_id], self)
		return []
	
	var namespace = split[0]
	var loot_tables = _loot_tables.get(namespace, null)
	if loot_tables == null:
		Logger.warn("The loot_table namespace '%s' for '%s' could not be found" % [namespace, loot_table_id], self)
		return []
	
	var loot_table = loot_tables.get(split[1], null)
	if loot_table == null:
		Logger.warn("The loot_table '%s' could not be found in the namespace '%s'" % [split[1], namespace], self)
		return []
	
	return _get_pool_item_stacks(loot_table, iteration, loot_table_id)

func _get_pool_item_stacks(pools: Array, iteration: int, info_str: String) -> Array:
	
	var items = []
	
	for pool in pools:
		# TODO xFrednet 2020.08.29: Add pool conditions #48
		# Note: It's always true for now
		for entry in pool[LootTableJSON.POOL_ENTRIES]:
			info_str = info_str + "." + pool[LootTableJSON.POOL_NAME]
			var entry_items = _get_pool_entry_item_stacks(entry, iteration, info_str)
			print(entry)
			for item in entry_items:
				items.append(item)
	
	return items

func _get_pool_entry_item_stacks(entry: Dictionary, iteration: int, info_str: String) -> Array:
	# "type": ("item"|"loot_table"),
	# "content_id": (<item_name>|<loot_table_id>),
	# "chance": (0.0-1.0),
	# "count_matrix": [<chance>, <count>]
	var role = randf()
	if !(role < entry[LootTableJSON.ENTRY_CHANCE]):
		return []
	
	if entry[LootTableJSON.ENTRY_TYPE] == ENTRY_TYPE_ITEM:
		# ItemInfo
		var item_id = entry[LootTableJSON.ENTRY_CONTENT_ID]
		var item_info = ItemInfoManager.get_item_info(item_id)
		if (item_info == null):
			Logger.warn("[%s] The item info for the ID '%s' could not be found" % [info_str, item_id], self)
			return [] 
		
		var count_matrix = entry[LootTableJSON.ENTRY_COUNT_MATRIX]
		var count_role = randf()
		for chance_index in range(0, count_matrix.size(), 2):
			if (count_role <= count_matrix[chance_index]):
				# Out of bounds check
				var count_index = chance_index + 1
				if (count_index >= count_matrix.size()):
					Logger.warn("[%s] The count matrix for the item '%s' has no item_count for the chance" % [info_str, item_id], self)
					return []
				
				# count
				var count = int(count_matrix[count_index])
				if count == 0:
					Logger.warn("[%s] The count in the count_matrix for the item '%s' is 0" % [info_str, item_id], self)
					return []
					
				return [ItemStack.new(item_info, count)]
			else:
				count_role -= count_matrix[chance_index]
			
		Logger.warn("[%s] The count_matrix for '%s' didn't catch the role of '%0.3f'" % [info_str, item_id, count_role], self)
		return []
		
	elif entry[LootTableJSON.ENTRY_TYPE] == ENTRY_TYPE_LOOT_TABLE:
		var loot_table_id = entry[LootTableJSON.ENTRY_CONTENT_ID]
		return get_loot_table_item_stacks(loot_table_id, iteration + 1)
	
	Logger.warn("[%s] The entry content could not be determined" % info_str, self)
	return []

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
