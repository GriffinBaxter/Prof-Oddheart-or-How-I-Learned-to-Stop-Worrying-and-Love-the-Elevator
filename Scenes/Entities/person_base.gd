extends CharacterBody3D

@export var speed: float = 5.0

var inElevator: bool = false

func _physics_process(delta: float) -> void:
	if !inElevator:
		position.x += speed * delta

func setInElevator(value: bool):
	print("we hit da body brother")
	inElevator = value
