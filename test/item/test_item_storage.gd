extends WAT.Test

var nullID = ItemInfoManager.NULL_ITEM_ID
var testIDs = ItemInfoManager.TEST_ITEM_IDS
var nullInfo = ItemInfoManager.get_item_info(nullID)
var testInfos = [
	ItemInfoManager.get_item_info(testIDs[0]), ItemInfoManager.get_item_info(testIDs[1]),
	ItemInfoManager.get_item_info(testIDs[2]), ItemInfoManager.get_item_info(testIDs[3]),
	ItemInfoManager.get_item_info(testIDs[4]), ItemInfoManager.get_item_info(testIDs[5]),
	ItemInfoManager.get_item_info(testIDs[6]), ItemInfoManager.get_item_info(testIDs[7]),
	ItemInfoManager.get_item_info(testIDs[8]), ItemInfoManager.get_item_info(testIDs[9])
]

func title():
	return "ItemStorage Tests"

func test_push_stack():
	describe("Pushes a stack into storage and tests all other trash")
	
	var storage = CommonStorage.new(1, 10.0)
	
	asserts.is_null(storage.pull_stack_first(), "Empty storage returns null")
	asserts.is_null(storage.pull_stack_by_id(nullID), "Empty storage returns null")
	asserts.is_null(storage.pull_stack_by_info(nullInfo), "Empty storage returns null")
	
	storage.push_stack(ItemStack.new(testInfos[0], 5))
	
	asserts.is_true(storage.has_stack(testInfos[0]), "Has test return true")
	asserts.is_false(storage.has_stack(testInfos[1]), "Has test return false")
	asserts.is_not_null(storage.get_stack_first(), "Filled storage returns not null")
	asserts.is_not_null(storage.get_stack_by_id(testIDs[0]), "Filled storage finds stack")
	asserts.is_not_null(storage.get_stack_by_info(testInfos[0]), "Filled storage finds stack")
	
	asserts.is_null(storage.get_stack_by_id(nullID), "Filled storage doesn't find nullID")
	asserts.is_null(storage.get_stack_by_info(nullInfo), "Filled storage doesn't find nullInfo")
	
	var stack = storage.pull_stack_first()
	asserts.is_not_null(stack, "Stack returned successfully")
	asserts.is_null(storage.pull_stack_first(), "Empty storage is empty")
	storage.push_stack(stack)
	stack = null
	
	stack = storage.pull_stack_by_id(testIDs[0])
	asserts.is_not_null(stack, "Stack returned successfully")
	asserts.is_null(storage.pull_stack_first(), "Empty storage is empty")
	storage.push_stack(stack)
	stack = null
	
	stack = storage.pull_stack_by_info(testInfos[0])
	asserts.is_not_null(stack, "Stack returned successfully")
	asserts.is_null(storage.pull_stack_first(), "Empty storage is empty")
	storage.push_stack(stack)
	stack = null

func test_common_storage_slot_count():
	describe("This tests the slot count of the common storage over the interface")
	
	testInfos[6]._test_util_set_weight(0.5)
	testInfos[7]._test_util_set_weight(5.0)
	testInfos[8]._test_util_set_weight(7.0)
	testInfos[9]._test_util_set_weight(10.0)
	
	var storage = CommonStorage.new(1, 10.0)
	storage.push_stack(ItemStack.new(testInfos[0], 5))
	asserts.is_equal(storage.get_free_weight(), 5.0, "Correct free storage space")
	asserts.is_equal(storage.calc_accepted_count(testInfos[0]), 5, "Accepts 5 more items from item id 0")
	asserts.is_equal(storage.calc_accepted_count(testInfos[1]), 0, "Accepts 0 items from item id 1 (Slots full)")
	
	storage = CommonStorage.new(5, 100.0)
	storage.push_stack(ItemStack.new(testInfos[0], 30))
	asserts.is_equal(storage.calc_accepted_count(testInfos[6]), 140, "Accepts 140 items with a weight of  0.5 (70 weight free)")
	asserts.is_equal(storage.calc_accepted_count(testInfos[7]),  14, "Accepts  14 items with a weight of  5.0 (70 weight free)")
	asserts.is_equal(storage.calc_accepted_count(testInfos[8]),  10, "Accepts  10 items with a weight of  7.0 (70 weight free)")
	asserts.is_equal(storage.calc_accepted_count(testInfos[9]),   7, "Accepts   7 items with a weight of 10.0 (70 weight free)")
	
	storage = CommonStorage.new(3, 100.0)
	storage.push_stack(ItemStack.new(testInfos[0], 30))
	storage.push_stack(ItemStack.new(testInfos[1], 30))
	storage.push_stack(ItemStack.new(testInfos[2], 30))
	asserts.is_equal(storage.calc_accepted_count(testInfos[0]),  10, "Accepts 10 items into filled slot (id 0)")
	asserts.is_equal(storage.calc_accepted_count(testInfos[1]),  10, "Accepts 10 items into filled slot (id 1)")
	asserts.is_equal(storage.calc_accepted_count(testInfos[2]),  10, "Accepts 10 items into filled slot (id 2)")
	asserts.is_equal(storage.calc_accepted_count(testInfos[3]),   0, "Accepts  0 items from new item (slots full)")
	
func post():
	# reset weights
	for info in testInfos:
		info._test_util_set_weight(1.0)
