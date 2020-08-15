extends RigidBody2D

class_name Meteoroid

var health : float = 1.0
export(float, 10.0, 10000.0) var max_health : float = 10.0
export(String) var loot_table_entry : String = "loot:meteoroid.x"
export(String) var name_key : String = "m:"

var _last_linear_velocity : Vector2 = Vector2(0, 0) 

func _init() -> void:
	set_meta(ComponentStatic.HEALTH_COMPONENT, HealthComponent.new(self, 100.0))
	set_meta(ComponentStatic.METEOROID_COLLISION_COMPONENT, MeteoroidCollisionComponent.new(self, 0.5, 0.5))
	ComponentStatic.call_create_links(self)

func _ready():
	health = max_health
	
	# Enable contact monitor
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	var err = connect("body_entered", self, "_body_entered")
	assert(err == OK)
	
	pass

func _physics_process(_delta):
	self._last_linear_velocity = self.linear_velocity

# _on_meteoroid_collision is called by the meteoroid with the collision force. 
# The colliding object decides what it does with the force and so on. Note that
# the direction und linear force of the meteoroid is determined by the engine 
# and doesn't need to be changed
func _body_entered(other: Node) -> void:
	if self.is_queued_for_deletion():
		return
	
	# Calculate the force
	var lost_velocity = self._last_linear_velocity - self.linear_velocity
	var force = lost_velocity * self.weight
	
	# Collision
	var collision_com = other.get_meta(ComponentStatic.METEOROID_COLLISION_COMPONENT)
	if (collision_com != null):
		collision_com.on_meteoroid_collision(self, force)
	else:
		assert(false)

func get_loot_table_key() -> String:
	return loot_table_entry
