extends ItemStorage

func pull_stack_first(count: int = WHOLE_STACK) -> ItemStack:
	
func pull_stack_by_info(item_info: ItemInfo, count: int = WHOLE_STACK) -> ItemStack:

func push_stack(stack: ItemStack) -> void:
 
#########################
# Content Info
#########################
func get_stack_first() -> ItemStack:

func get_stack_by_info(item_info: ItemInfo) -> ItemStack:

#########################
# Storage Info
#########################
func calc_accepted_count(item_info: ItemInfo) -> int:

func get_weight() -> float:

func get_weight_capacity() -> float:
