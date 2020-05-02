extends Reference

class_name ItemStorage

const WHOLE_STACK = -1
const INT_MAX: int = 0xffffffff

#########################
# Content interaction
#########################
func pull_stack_first(_count: int = WHOLE_STACK) -> ItemStack:
	assert("Not implemented")
	var temp = null
	return temp

func pull_stack_by_id(item_id: String, _count: int = WHOLE_STACK) -> ItemStack:
	var info = ItemInfoManager.get_item_info(item_id)
	return pull_stack_by_info(info)
	
# This finds the items with the given ItemInfo inside the storage.
# A count of -1 requests the entire stack. Otherwise, it will return the
# minimum of (count, contained_item_count). It can also return null if the 
# item isn't inside the container
#
# Input:
#   * item_info: The info of the searched item
#   * count: The requested item count or -1 for the entire stack
#
# Returns null || ItemStack
func pull_stack_by_info(_item_info: ItemInfo, _count: int = WHOLE_STACK) -> ItemStack:
	assert("Not implemented")
	var temp = null
	return temp

func push_stack(_stack: ItemStack) -> void:
	assert("Not implemented")
	
func _drop_item(_stack: ItemStack) -> void:
	# TODO
	assert(false)
	pass
 
#########################
# Content Info
#########################
func get_stack_first() -> ItemStack:
	assert("Not implemented")
	var temp = null
	return temp

func get_stack_by_id(item_id) -> ItemStack:
	var info = ItemInfoManager.get_item_info(item_id)
	return get_stack_by_info(info)

func get_stack_by_info(_item_info: ItemInfo) -> ItemStack:
	assert("Not implemented")
	var temp = null
	return temp

#########################
# Storage Info
#########################
func has_item(_item_info) -> bool:
	assert("Not implemented")
	return false

func calc_accepted_count(_item_info: ItemInfo) -> int:
	assert("Not implemented")
	return 0
	
func accepts_item(item_info : ItemInfo) -> bool:
	return calc_accepted_count(item_info) != 0

func get_weight() -> float:
	assert("Not implemented")
	return 0.0

func get_weight_capacity() -> float:
	assert("Not implemented")
	return 0.0

func get_free_weight() -> float:
	return get_weight_capacity() - get_weight()

#########################
# Util
#########################
func _split_stack(src_stack: ItemStack, count: int) -> ItemStack:
	src_stack.remove_count(count)
	return ItemStack.new(src_stack.get_item_info(), count)
