extends RigidBody2D

class_name Meteoroid

var health : float = 1.0
export(float, 10.0, 10000.0) var max_health : float = 10.0
export(String) var loot_table_entry : String = "loot:meteoroid.x"
export(String) var name_key : String = "m:"

var _last_linear_velocity : Vector2 = Vector2(0, 0) 

func _ready():
	health = max_health
	
	# Enable contact monitor
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	connect("body_entered", self, "_body_entered")
	
	pass

func _physics_process(delta):
	self._last_linear_velocity = self.linear_velocity

# _on_meteoroid_collision is called by the meteoroid with the collision force. 
# The colliding object decides what it does with the force and so on. Note that
# the direction und linear force of the meteoroid is determined by the engine 
# and doesn't need to be changed
func _body_entered(other: Node) -> void:
	if self.is_queued_for_deletion():
		return
	
	if (other.has_method("_on_meteoroid_collision")):
		var lost_velocity = self._last_linear_velocity - self.linear_velocity
		var force = lost_velocity * self.weight
		other._on_meteoroid_collision(self, force)
	pass

func _on_meteoroid_collision(other: Node, force : Vector2) -> void:
	if self.is_queued_for_deletion():
		return
	
	var damage = force.length()
	self.deal_damage(damage / 2)
	other.deal_damage(damage / 2)

func deal_damage(damage: float) -> void:
	health -= damage
	if (health <= 0.0):
		_destruction()

func _destruction() -> void:
	
	# TODO frist 11.08.2020: Drop ressources on destcruction #34
	
	get_parent().remove_child(self)
	self.queue_free()

func get_max_health() -> float:
	return max_health

func get_health() -> float:
	return health

func get_loot_table_key() -> String:
	return loot_table_entry
