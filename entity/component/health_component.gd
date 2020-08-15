extends ComponentBase

class_name HealthComponent

var _health : float = 0.0 setget , get_health
var _max_health : float = 0.0 setget , get_max_health

# TODO xFrednet 15.08.2020: Display the owners health, this is tracted in issue #43

func _init(owner: Node, max_health: float).(owner) -> void:
	_max_health = max_health
	_health = _max_health

func heal(amount: float) -> void:
	_health = min(_health + amount, _max_health)

func damage(amount: float) -> void:
	_health -= amount
	if (_health <= 0.0):
		if (_owner.has_method("on_death")):
			_owner.call("on_death")
		
		_kill_owner()
	
func _kill_owner() -> void:
	_owner.get_parent().remove_child(_owner)
	_owner.queue_free()

# Getters and setters
func get_max_health() -> float:
	return _max_health

func get_health() -> float:
	return _health
