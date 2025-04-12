extends CharacterBody3D

@export var speed: float = 0.05

var in_elevator: bool = false


func _physics_process(_delta: float) -> void:
	if !in_elevator:
		position.x += speed
