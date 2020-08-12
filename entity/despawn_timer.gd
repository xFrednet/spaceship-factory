extends Timer

class_name DespawnTimer

# This despawns (i.e. removes) the parent from the scene. This is done by
# removing the parent and it's children from the tree and queueing it to be
# freed. 
#
# The timeout will first call on_despawn if the method exists. Note that
# this doesn't stop the removement from the working tree. This is just ment for
# animations and so on

func _init(despawn_time: float):
	connect("timeout", self, "_on_timeout")
	set_wait_time(despawn_time)
	set_autostart(true)

func refresh_timer():
	start(0)

func _on_timeout():
	var parent = get_parent()
	if parent.has_method("on_despawn"):
		parent.on_despawn()
	
	parent.get_parent().remove_child(parent)
	parent.queue_free()
