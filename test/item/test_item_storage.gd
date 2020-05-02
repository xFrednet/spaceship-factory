extends WAT.Test

var nullID = ItemInfoManager.NULL_ITEM_INFO_ID
var testID = ItemInfoManager.TEST_ITEM_INFO_ID
var nullInfo = ItemInfoManager.get_item_info(nullID)
var testInfo = ItemInfoManager.get_item_info(testID)

func title():
	return "ItemStorage Tests"

func test_push_stack():
	describe("Pushes a stack into storage and tests all other trash")
	
	var storage = CommonStorage.new(1, 10.0)
	
	asserts.is_null(storage.pull_stack_first(), "Empty storage returns null")
	asserts.is_null(storage.pull_stack_by_id(nullID), "Empty storage returns null")
	asserts.is_null(storage.pull_stack_by_info(nullInfo), "Empty storage returns null")
	
	storage.push_stack(ItemStack.new(testInfo, 5))
	
	asserts.is_not_null(storage.get_stack_first(), "Filled storage returns not null")
	asserts.is_not_null(storage.get_stack_by_id(testID), "Filled storage finds stack")
	asserts.is_not_null(storage.get_stack_by_info(testInfo), "Filled storage finds stack")
	
	asserts.is_null(storage.get_stack_by_id(nullID), "Filled storage doesn't find nullID")
	asserts.is_null(storage.get_stack_by_info(nullInfo), "Filled storage doesn't find nullInfo")
	
	var stack = storage.pull_stack_first()
	asserts.is_not_null(stack, "Stack returned successfully")
	asserts.is_null(storage.pull_stack_first(), "Empty storage is empty")
	storage.push_stack(stack)
	stack = null
	
	stack = storage.pull_stack_by_id(testID)
	asserts.is_not_null(stack, "Stack returned successfully")
	asserts.is_null(storage.pull_stack_first(), "Empty storage is empty")
	storage.push_stack(stack)
	stack = null
	
	stack = storage.pull_stack_by_info(testInfo)
	asserts.is_not_null(stack, "Stack returned successfully")
	asserts.is_null(storage.pull_stack_first(), "Empty storage is empty")
	storage.push_stack(stack)
	stack = null

