extends Node3D

@onready var sound_player = $MainSoundPlayer

func _ready() -> void:
	sound_player.play()

func _on_go_to_play_body_entered(body: Node3D) -> void:
	if body.is_in_group("elevator"):
		get_tree().change_scene_to_file("res://main.tscn")
