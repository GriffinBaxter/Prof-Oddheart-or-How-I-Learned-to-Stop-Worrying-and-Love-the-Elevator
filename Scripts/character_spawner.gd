extends Node3D

@export var character_scene: PackedScene

@onready var csg_mesh_3d: CSGMesh3D = $CSGMesh3D


func _ready() -> void:
	csg_mesh_3d.hide()


func spawn() -> void:
	var character := character_scene.instantiate()
	character.position = global_position
	get_tree().root.get_child(2).add_child(character)
