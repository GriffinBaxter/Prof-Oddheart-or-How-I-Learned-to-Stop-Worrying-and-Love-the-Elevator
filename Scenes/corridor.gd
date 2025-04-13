extends Node3D


func _on_drop_off_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("people") and body.in_elevator:
		body.in_elevator = false
