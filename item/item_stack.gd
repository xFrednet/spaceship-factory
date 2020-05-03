extends Reference

class_name ItemStack

var _item_info : ItemInfo setget , get_item_info
var _item_count : int setget , get_count

func _init(info, count):
	if info is String:
		info = ItemInfoManager.get_item_info(info)
	
	assert(info != null)
	_item_info = info
	assert((count is int) && count > 0)
	_item_count = count

func get_item_info() -> ItemInfo:
	return _item_info

func can_stack(other) -> bool:
	return _item_info.can_stack(other.get_item_info())
	# TODO xFrednet 25.04.2020: Check metatdata or other attributes when the get added

func add_stack(other) -> void:
	assert(can_stack(other))
	add_count(other.get_count())

func add_count(count : int) -> void:
	 _item_count += count
	
func get_count() -> int:
	return _item_count

func remove_count(count: int) -> void:
	_item_count -= count
	assert(_item_count > 0)

###################
# weight
###################
func get_weight() -> float:
	return _item_count * _item_info.get_weight()
