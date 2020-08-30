extends ComponentBase

class_name DestructionComponent

const PARTICLE_MARTERIAL = preload("res://entity/component/res/destruction_particle_material.tres")
const PARTICLE_TEXTURE = preload("res://resource_pack/spaceship_factory/texture/particle/destruction.png")

# values
var _loot_table_entry = null
var _particle_amount: int = 0

# methods
func _init(owner: Node, loot_table = null, amount = 8).(owner) -> void:
	_particle_amount = amount
	_loot_table_entry = loot_table

func _create_particles():
	var lifetime = 1.0
	
	var par = Particles2D.new()
	par.set_amount(_particle_amount)
	par.set_lifetime(lifetime)
	par.set_emitting(true)
	par.set_explosiveness_ratio(1.0)
	par.set_randomness_ratio(1.0)
	par.set_one_shot(true)
	par.set_process_material(PARTICLE_MARTERIAL)
	par.set_texture(PARTICLE_TEXTURE)
	
	par.add_child(DespawnTimer.new(lifetime))
	
	return par

func destruct_owner():
	# Values
	var parent = _owner.get_parent()
	var position  = _owner.get_position()
	
	# Particles
	if (_particle_amount != 0):
		var particles = _create_particles()
		particles.set_position(position)
		parent.add_child(particles)
	
	# LootTable
	if (_loot_table_entry != null):
		var entities = LootTableManager.get_loot_table_item_entities(_loot_table_entry)
		for e in entities:
			e.set_position(position)
			parent.add_child(e)
	
	# Die
	parent.remove_child(_owner)
