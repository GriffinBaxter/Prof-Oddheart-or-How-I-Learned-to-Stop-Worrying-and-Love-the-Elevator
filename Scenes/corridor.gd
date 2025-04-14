extends Node3D

var colour: Color = [Color.RED, Color.GREEN, Color.BLUE].pick_random()

@onready var corridor_boxes: Array[CSGBox3D] = [$Back, $Top, $Bottom]


func _ready() -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = colour
	for box in corridor_boxes:
		box.material = material


func _on_drop_off_area_left_body_entered(body: Node3D) -> void:
	if body.is_in_group("people") and body.in_elevator:
		body.drop_off(colour, 1)


func _on_drop_off_area_right_body_entered(body: Node3D) -> void:
	if body.is_in_group("people") and body.in_elevator:
		body.drop_off(colour, -1)
