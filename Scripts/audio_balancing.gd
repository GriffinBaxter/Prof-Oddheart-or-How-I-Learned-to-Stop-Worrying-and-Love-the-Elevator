extends Node

var conversations: int
var other: int
var conversation_detected := false


func _ready() -> void:
	conversations = AudioServer.get_bus_index("Conversations")
	other = AudioServer.get_bus_index("Other")


func _process(_delta: float) -> void:
	if AudioServer.get_bus_peak_volume_right_db(conversations, 0) > -200 and !conversation_detected:
		conversation_detected = true
		var tween := get_tree().create_tween()
		tween.tween_method(change_other_volume, 0, -20, 0.25)
		change_other_volume(-20)
		await get_tree().create_timer(0.25).timeout
		tween.stop()
	elif (
		AudioServer.get_bus_peak_volume_right_db(conversations, 0) <= -200 and conversation_detected
	):
		conversation_detected = false
		var tween := get_tree().create_tween()
		tween.tween_method(change_other_volume, -20, 0, 1)
		change_other_volume(0)
		await get_tree().create_timer(1).timeout
		tween.stop()


func change_other_volume(new_volume: float) -> void:
	AudioServer.set_bus_volume_db(other, new_volume)
