extends WAT.Test

func title():
	return "Hello to the world of tests :)"
	
func test_print_hello_test():
	describe("This is the first test.")
	
	asserts.is_true(true, "This is true :)")
	asserts.is_false(false, "This is false :)")
