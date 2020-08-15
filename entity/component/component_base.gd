extends Reference

class_name ComponentBase

# Values
var _owner : Node

# Methods
func _init(owner: Node) -> void:
	_owner = owner

func get_logger_name() -> String:
	return self.get_class();

# This method should be called when all components are registered. It allowes
# the components to create links to other components they want to comunicate with.
func create_links() -> void:
	pass
