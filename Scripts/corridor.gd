extends Node3D

var colour: Color = [Color.RED, Color.GREEN, Color.BLUE].pick_random()

@onready var corridor_boxes: Array[CSGBox3D] = [$Back, $Top, $Bottom]
@onready var corridor_box_transparent: CSGBox3D = $Front


func _ready() -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = colour
	for box in corridor_boxes:
		box.material = material
	var transparent_material := StandardMaterial3D.new()
	transparent_material.albedo_color = colour - Color(0, 0, 0, 0.75)
	transparent_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	corridor_box_transparent.material = transparent_material


func _on_drop_off_area_left_body_entered(body: Node3D) -> void:
	if body.is_in_group("people") and body.in_elevator:
		body.drop_off(1, colour)


func _on_drop_off_area_right_body_entered(body: Node3D) -> void:
	if body.is_in_group("people") and body.in_elevator:
		body.drop_off(-1, colour)
