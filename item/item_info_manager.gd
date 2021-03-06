extends Node

const ITEM_INFO_DATAFILL_FILE = "res://resource_pack/spaceship_factory/item_info_datafill.txt"
const NULL_ITEM_ID = "sf:item:null"
const TEST_ITEM_IDS = [
	"sf:item:test0", "sf:item:test1",
	"sf:item:test2", "sf:item:test3",
	"sf:item:test4", "sf:item:test5",
	"sf:item:test6", "sf:item:test7",
	"sf:item:test8", "sf:item:test9"
]

var _items = Dictionary()

func _ready():
	_load_item_info_datafill()

func get_item_info(id: String) -> ItemInfo:
	var item = _items.get(id)
	
	if item == null:
		Logger.warn("ItemInfo unavailable: %s" % id, self)
		return _items.get(NULL_ITEM_ID)
	else:
		return item

###################
# Internals
###################
func _load_item_info_datafill():
	var file = File.new()
	if file.open(ITEM_INFO_DATAFILL_FILE, File.READ) != OK:
		Logger.error("Unable to load the item_info_data form: %s" % ITEM_INFO_DATAFILL_FILE, self)
		return
	
	var _header = file.get_line()
	var line = file.get_line()
	
	while !line.empty():
		var item = ItemInfo.new(line)
		if !item.get_id().empty():
			if !_items.has(item.get_id()):
				_items[item.get_id()] = item
			else:
				Logger.warn("Item with duplicate ID was found: %s" % item, self)
		
		line = file.get_line()
	
	file.close()
	Logger.info("Loading complete. Loaded %d items" % _items.size(), self)


func get_logger_name() -> String:
	return "ItemInfoManager";
