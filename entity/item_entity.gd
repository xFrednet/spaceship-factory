extends RigidBody2D
class_name ItemEntity

const COLLISION_RADIUS = 8.0
const DESPAWN_TIMER = 100.0

var _item_stack : ItemStack

func _init(item_stack: ItemStack) -> void:
	_item_stack = item_stack
	
	set_gravity_scale(0.1)
	
	var sprite = Sprite.new()
	sprite.set_texture(item_stack.get_item_info().get_texture())
	add_child(sprite)
	
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.set_radius(COLLISION_RADIUS)
	collision.set_shape(shape)
	add_child(collision)
	set_collision_layer(CollisionStatic.ITEM_LAYER)
	set_collision_mask(CollisionStatic.ITEM_MASK)
	
	add_child(DespawnTimer.new(DESPAWN_TIMER))

