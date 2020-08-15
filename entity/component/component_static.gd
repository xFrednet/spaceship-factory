extends Node

const HEALTH_COMPONENT                 = "HealthComponent"
const METEOROID_COLLISION_COMPONENT    = "MeteoroidCollisionComponent"

# This method calls create_links on all components in the nodes metadata see
# BaseComponent.create_links for further information
func call_create_links(owner: Node) -> void:
	var meta_list = owner.get_meta_list()
	
	for meta_name in meta_list:
		var meta = owner.get_meta(meta_name)
		if (meta.has_method("create_links")):
			meta.call("create_links")
	
	pass
