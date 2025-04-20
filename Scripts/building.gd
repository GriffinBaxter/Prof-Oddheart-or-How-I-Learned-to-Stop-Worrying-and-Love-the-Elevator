extends Node3D

@onready var front_corridors: Array[Node3D] = [
	$"Corridors/3CorridorRow2", $"Corridors/3CorridorRow4", $"Corridors/3CorridorRow6"
]


func hide_front_corridors() -> void:
	for corridor in front_corridors:
		corridor.hide()


func show_front_corridors() -> void:
	for corridor in front_corridors:
		corridor.show()
