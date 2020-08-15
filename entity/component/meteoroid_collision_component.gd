extends ComponentBase

class_name MeteoroidCollisionComponent

const FORCE_MULTIPLIER = 0.01

# values
var _owner_damage_multiplier: float
var _meteoroid_damage_multiplier: float

var _health_component: HealthComponent

# methods
func _init(
		owner: Node,
		owner_damage_multiplier: float,
		meteoroid_damage_multiplier: float).(owner) -> void:
	_owner_damage_multiplier = owner_damage_multiplier
	_meteoroid_damage_multiplier = meteoroid_damage_multiplier
	
func create_links() -> void:
	_health_component = _owner.get_meta(ComponentStatic.HEALTH_COMPONENT)
	assert(_health_component != null)

func on_meteoroid_collision(meteoroid: Node2D, force: Vector2) -> void:
	if _owner.is_queued_for_deletion():
		return
	
	var metoroid_health_component = meteoroid.get_meta(ComponentStatic.HEALTH_COMPONENT)
	assert(metoroid_health_component != null)
	
	var damage = force.length() * FORCE_MULTIPLIER
	_health_component.damage(damage * _owner_damage_multiplier)
	metoroid_health_component.damage(damage * _meteoroid_damage_multiplier)
