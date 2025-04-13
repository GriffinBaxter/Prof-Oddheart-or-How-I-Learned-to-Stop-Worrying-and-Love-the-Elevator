extends Node3D

const COLOURS = [Color.RED, Color.GREEN, Color.BLUE]
@onready var corridor_boxes: Array[CSGBox3D] = [$Back, $Top, $Bottom]


func _ready() -> void:
	var material = StandardMaterial3D.new()
	material.albedo_color = COLOURS.pick_random()
	for box in corridor_boxes:
		box.material = material


func _on_drop_off_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("people") and body.in_elevator:
		body.in_elevator = false
