extends WAT.Test

var nullID = ItemInfoManager.NULL_ITEM_ID
var testID = ItemInfoManager.TEST_ITEM_IDS[0]
var nullInfo = ItemInfoManager.get_item_info(nullID)
var testInfo = ItemInfoManager.get_item_info(testID)

func title():
	return "ItemStack Tests"
	
func test_init_item_stack():
	describe("Test if ItemStack._init works")
	asserts.is_not_equal(nullInfo, testInfo) # Test that the import worked correctly
	
	var stack = null
	
	#
	# From String
	#
	stack = ItemStack.new(nullID, 60)
	asserts.is_equal(stack.get_item_info(), nullInfo)
	asserts.is_equal(stack.get_count(), 60)

	stack = ItemStack.new(testID, 99)
	asserts.is_equal(stack.get_item_info(), testInfo)
	asserts.is_equal(stack.get_count(), 99)
	
	#
	# From info
	#
	stack = ItemStack.new(nullInfo, 9)
	asserts.is_equal(stack.get_item_info(), nullInfo)
	asserts.is_equal(stack.get_count(), 9)

	stack = ItemStack.new(testInfo, 1278)
	asserts.is_equal(stack.get_item_info(), testInfo)
	asserts.is_equal(stack.get_count(), 1278)
	
func test_can_stack():
	describe("Test if ItemStack.can_stack works")
	
	var nullStack = ItemStack.new(nullID, 1)
	var testStack = ItemStack.new(testID, 1)
	
	asserts.is_true(nullStack.can_stack(ItemStack.new(nullID, 1)), "null + null")
	asserts.is_false(nullStack.can_stack(ItemStack.new(testID, 1)), "null + test")
	
	asserts.is_true(testStack.can_stack(ItemStack.new(testID, 1)), "test + test")
	asserts.is_false(testStack.can_stack(ItemStack.new(nullID, 1)), "test + null")

func test_add_stack():
	describe("Test if ItemStack.add_stack works")
	
	var nullStack = ItemStack.new(nullID, 1)
	var testStack = ItemStack.new(testID, 1)
	
	nullStack.add_stack(ItemStack.new(nullID, 1))
	asserts.is_equal(nullStack.get_count(), 2, "1 + 1")
	nullStack.add_stack(ItemStack.new(nullID, 2))
	asserts.is_equal(nullStack.get_count(), 4, "2 + 2")
	nullStack.add_stack(ItemStack.new(nullID, 96))
	asserts.is_equal(nullStack.get_count(), 100, "4 + 96")
	
	testStack.add_stack(ItemStack.new(testID, 7))
	asserts.is_equal(testStack.get_count(), 8, "1 + 7")
	testStack.add_stack(ItemStack.new(testID, 2))
	asserts.is_equal(testStack.get_count(), 10, "8 + 2")
	testStack.add_stack(ItemStack.new(testID, 99))
	asserts.is_equal(testStack.get_count(), 109, "10 + 99")
