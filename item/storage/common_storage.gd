extends ItemStorage

class_name CommonStorage

var _slot_count: int
var _slots: Array
var _weight: float
var _weight_capacity: float

func _init(slot_count: int, weight_capacity: float):
	_slot_count = slot_count
	_slots = Array()
	_weight = 0.0
	_weight_capacity = weight_capacity

func pull_stack_first(count: int = WHOLE_STACK) -> ItemStack:
	if _slots.size() > 0:
		return pull_stack_by_info(_slots.front().get_item_info(), count)
	else:
		var temp = null
		return temp

func pull_stack_by_info(item_info: ItemInfo, count: int = WHOLE_STACK) -> ItemStack:
	var src_stack = null
	var res_stack = null
	
	var stack_index = 0;
	for index in range(_slots.size()):
		var item = _slots[index]
		if item != null && item.get_item_info().equals(item_info):
			src_stack = item
			stack_index = index
			break
	
	if src_stack == null:
		return src_stack
	
	if count == WHOLE_STACK:
		count = src_stack.get_count()
	
	if count == src_stack.get_count():
		_slots.remove(stack_index)
		res_stack = src_stack
	else:
		res_stack = src_stack.split(count)
	
	_weight -= res_stack.get_weight()
	
	return src_stack

func push_stack(stack: ItemStack) -> void:
	var count = calc_accepted_count(stack.get_item_info())
	
	var drop_stack = null
	if count > 0:
		# Test if something has to be dropped
		if count < stack.get_count():
			# The new count in stack will be count
			drop_stack = _split_stack(stack, stack.get_count() - count)
		
		var storage_stack = get_stack_by_info(stack.get_item_info())
		if storage_stack != null:
			storage_stack.add_stack(stack)
		else:
			_slots.append(stack)
		
		_weight += stack.get_weight()
		stack = null
		
	else:
		drop_stack = stack
	
	if drop_stack != null:
		_drop_item(drop_stack)

#########################
# Content Info
#########################
func get_stack_by_info(item_info: ItemInfo) -> ItemStack:
	var stack = null
	for index in range(_slots.size()):
		var item = _slots[index]
		if item != null && item.get_item_info().equals(item_info):
			stack = item
			break
	
	return stack

#########################
# Storage Info
#########################
func get_stack_first() -> ItemStack:
	if _slots.size() > 0:
		return _slots.front()
	else:
		var temp = null
		return temp

func calc_accepted_count(item_info : ItemInfo) -> int:
	# Check if the item fits in the slots
	var storage_stack = get_stack_by_info(item_info)
	if storage_stack == null:
		if _slots.size() >= _slot_count:
			return 0
	
	# Check if the weight fits
	var free_space = get_free_weight()
	var item_weight = item_info.get_weight()
	
	if item_weight > 0:
		return int(free_space / item_weight)
	else:
		return INT_MAX

func get_weight() -> float:
	return _weight

func get_weight_capacity() -> float:
	return _weight_capacity
