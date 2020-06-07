extends Node2D

class_name Spaceship

const STORAGE_SLOT_COUNT = 1000
const STORAGE_WEIGHT_LIMIT = 100000000.0

var _ship_storage: ItemStorage

func _init():
	GameData.spaceship = self
	_ship_storage = CommonStorage.new(STORAGE_SLOT_COUNT, STORAGE_WEIGHT_LIMIT)

func _ready():
	pass
