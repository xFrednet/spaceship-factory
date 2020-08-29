extends WAT.Test

const POOL_CHANCE_ITERATIONS = 10
const COUNT_MATRIX_TEST_ITERATIONS = 100

func title():
	return "LootTableManager Tests"

func start():
	LootTableManager.load_loot_tables("test", "res://test/item/test_loot_tables.json")

func pre():
	# Runs before each test method
	pass

func test_get_1_test0():
	var items = LootTableManager.get_loot_table_item_stacks("test:loot:test_get_1_test0")
	asserts.is_equal(items.size(), 1, "The loot_table should only return one item")
	var item: ItemStack = items[0]
	asserts.is_equal(item.get_item_info().get_id(), ItemInfoManager.TEST_ITEM_IDS[0])
	asserts.is_equal(item.get_count(), 1)

func test_infinite_loop_stop():
	LootTableManager.get_loot_table_item_stacks("test:loot:test_infinite_loop_stop")
	asserts.is_true(true, "The loop was stopped")

func test_get_2x_test0_4x_test1():
	var items = LootTableManager.get_loot_table_item_stacks("test:loot:test_get_2x_test0_4x_test1")
	asserts.is_equal(items.size(), 2, "The loot_table should return two items")
	
	var item0: ItemStack = items[0]
	asserts.is_equal(item0.get_item_info().get_id(), ItemInfoManager.TEST_ITEM_IDS[0])
	asserts.is_equal(item0.get_count(), 2)
	
	var item1: ItemStack = items[1]
	asserts.is_equal(item1.get_item_info().get_id(), ItemInfoManager.TEST_ITEM_IDS[1])
	asserts.is_equal(item1.get_count(), 4)

func test_call_get_2x_test0_4x_test1():
	var items = LootTableManager.get_loot_table_item_stacks("test:loot:test_call_get_2x_test0_4x_test1")
	asserts.is_equal(items.size(), 2, "The loot_table should return two items")
	
	var item0: ItemStack = items[0]
	asserts.is_equal(item0.get_item_info().get_id(), ItemInfoManager.TEST_ITEM_IDS[0])
	asserts.is_equal(item0.get_count(), 2)
	
	var item1: ItemStack = items[1]
	asserts.is_equal(item1.get_item_info().get_id(), ItemInfoManager.TEST_ITEM_IDS[1])
	asserts.is_equal(item1.get_count(), 4)

func test_pool_chance():
	# This is the thing about unit tests, how do you test chances?
	# There are several ways but idk
	
	var had_0 = false
	var had_1 = false
	
	for _it in range(0, POOL_CHANCE_ITERATIONS):
		var items = LootTableManager.get_loot_table_item_stacks("test:loot:test_pool_chance")
		if items.size() == 0:
			had_0 = true
		elif items.size() == 1:
			had_1 = true
	
	asserts.is_true(had_0, "Expected to get atleast 1 times 0 item in %d iterations (1/2 chance)" % POOL_CHANCE_ITERATIONS)
	asserts.is_true(had_1, "Expected to get atleast 1 times 1 item in %d iterations (1/2 chance)" % POOL_CHANCE_ITERATIONS)

func test_count_matrix():
	var achieved = [true, false, false, false, false, false, false, false, false, false, false]
	
	for _it in range(0, COUNT_MATRIX_TEST_ITERATIONS):
		var item = LootTableManager.get_loot_table_item_stacks("test:loot:test_count_matrix")[0]
		achieved[item.get_count()] = true
	
	for count in range(1, 11):
		asserts.is_true(achieved[count], "Expected to get a count of '%d' with a 1/10 chance atleast once in '%d' iterations" % [count, COUNT_MATRIX_TEST_ITERATIONS])

func post():
	# Runs after each test method
	pass

func end():
	# Runs after all other test related methods once
	pass
