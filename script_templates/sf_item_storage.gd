extends ItemStorage

func pull_stack_first(count: int = WHOLE_STACK) -> ItemStack:

func pull_stack_by_info(item_info: ItemInfo, count: int = WHOLE_STACK) -> ItemStack:

func push_stack(stack: ItemStack) -> void:
	_drop_item(stack)
 
#########################
# Content Info
#########################
func get_stack_first() -> ItemStack:

func get_stack_by_id(item_id) -> ItemStack:

func get_stack_by_info(item_info: ItemInfo) -> ItemStack:

#########################
# Storage Info
#########################
func has_item(item_info) -> bool:

func calc_accepted_count(item : ItemStack) -> int:

func get_weight() -> float:

func get_weight_capacity() -> float:

