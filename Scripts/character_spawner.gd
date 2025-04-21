extends Node3D

@export var character_scene: PackedScene

var colours := [Color.RED, Color.GREEN, Color.BLUE]

@onready var csg_mesh_3d: CSGMesh3D = $CSGMesh3D


func _ready() -> void:
	csg_mesh_3d.hide()
	var corridor_colour: Color = get_parent().colour
	colours.remove_at(colours.find(corridor_colour))


func spawn() -> void:
	var character := character_scene.instantiate()
	character.position = global_position
	character.colour = colours.pick_random()
	get_tree().root.get_child(2).add_child(character)
