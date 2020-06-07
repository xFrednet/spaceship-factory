extends Node

# This class contains all information and data from the currently loaded game.
# This is not the nicest way to structure a game but it is easy ... that's why 
# this class exists. Please dokument for each value who fills it.
#
# Note: All values from this class should be valid in game and invalid out of the game.
# 		So you probably / hopefully don't need to implement null checks. If you receive 
# 		null for some weird reason please contact your doctor or search for the problem 
# 		your self
#
# Best regards from xFrednet.

# Set by res://entity/spaceship/spaceship.gd during _init()
var spaceship
