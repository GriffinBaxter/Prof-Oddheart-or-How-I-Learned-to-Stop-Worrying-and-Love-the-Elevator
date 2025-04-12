extends CharacterBody3D

@export var speed: float = 0.05

var inElevator: bool = false


func _physics_process(_delta: float) -> void:
	if !inElevator:
		position.x += speed
