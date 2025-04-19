extends Node3D


func _on_go_to_play_body_entered(body: Node3D) -> void:
	if body.is_in_group("elevator"):
		call_deferred("change_scene_to_main")


func change_scene_to_main() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
