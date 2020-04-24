extends Node2D

const TILE_SIZE = 64

class_name SfTileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var tile = load("res://entity/spaceship/tile/test_tile/test_tile.tscn")
	self.set_tile(0, 0, tile.instance())
	self.set_tile(1, 1, tile.instance())
	self.set_tile(0, 3, tile.instance())
	self.set_tile(4, 2, tile.instance())
	self.print_tree_pretty()

# Tiles
func set_tile(tx : int, ty : int, node):
	var pos = self.get_world_pos(tx, ty)
	node.set_position(pos)
	node.set_name(self._get_tile_name(tx, ty))
	self.add_child(node)

func _get_tile_name(tx, ty) -> String:
	return "tile_" + str(tx) + "_" + str(ty)

# World pos
func get_world_x(tx : int):
	return tx * self.TILE_SIZE
func get_world_y(ty : int):
	return ty * self.TILE_SIZE
func get_world_pos(tx : int, ty : int):
	return Vector2(
		self.get_world_x(tx),
		self.get_world_y(ty))

func get_logger_name() -> String:
	return "TileMap"
