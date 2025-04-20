extends Node3D

const NEUTRAL_ARROW_COLOUR := Color.DIM_GRAY - Color(0, 0, 0, 0.5)
const GREEN_ARROW_COLOUR := Color("86ff4b")
const RED_ARROW_COLOUR := Color("ff413b")

@export var max_score := 200.
@export var min_score := -200.
@export var max_spawn_time: float
@export var min_spawn_time: float

var spawners: Array = [0]
var score: int = 0
var game_end := false
var elevator: CharacterBody3D

@onready var timer: Timer = $SpawnTimer
@onready var arrow_up: TextureRect = $UI/ArrowUp
@onready var arrow_down: TextureRect = $UI/ArrowDown
@onready var crowd_noise: AudioStreamPlayer = $CrowdNoise
@onready var game_lost: AudioStreamPlayer = $GameLost
@onready var game_won: AudioStreamPlayer = $GameWon
@onready var q_button_popup: Control = $UI/QButtonPopup
@onready var q: TextureRect = $UI/QButtonPopup/Q
@onready var thumbs_up: Sprite3D = $GameWonMoon/ThumbsUp


func _ready() -> void:
	elevator = get_tree().get_first_node_in_group("elevator")
	spawners = get_tree().get_nodes_in_group("spawners")
	q_button_popup.hide()
	handle_blinking_q_button()


func _process(_delta: float) -> void:
	if elevator.people_in_elevator.size() >= 3 and !game_end:
		q_button_popup.show()
	else:
		q_button_popup.hide()

	if !game_end:
		if score == 0:
			arrow_up.modulate = NEUTRAL_ARROW_COLOUR
			arrow_down.modulate = NEUTRAL_ARROW_COLOUR
		elif score >= max_score:
			arrow_up.modulate = GREEN_ARROW_COLOUR
		elif score > 0:
			arrow_up.modulate = (
				GREEN_ARROW_COLOUR * (score / max_score)
				+ NEUTRAL_ARROW_COLOUR * ((max_score - score) / max_score)
			)
			arrow_down.modulate = NEUTRAL_ARROW_COLOUR
		elif score <= min_score:
			arrow_up.modulate = RED_ARROW_COLOUR
		elif score < 0:
			arrow_up.modulate = NEUTRAL_ARROW_COLOUR
			arrow_down.modulate = (
				RED_ARROW_COLOUR * (score / min_score)
				+ NEUTRAL_ARROW_COLOUR * ((-min_score + score) / -min_score)
			)

		if score >= max_score:
			game_end = true
			ElevatorMusic.stop()
			crowd_noise.stop()
			game_won.play()
			elevator.won_game()
			await get_tree().create_timer(3).timeout
			var tween := create_tween()
			(
				tween
				. tween_property(thumbs_up, "position:x", -31.585, 4)
				. set_trans(Tween.TRANS_SINE)
				. set_ease(Tween.EASE_OUT)
			)
			await get_tree().create_timer(4).timeout
			tween.stop()
			await get_tree().create_timer(6).timeout
			get_tree().reload_current_scene()
		elif score <= min_score:
			game_end = true
			ElevatorMusic.stop()
			crowd_noise.stop()
			game_lost.play()
			elevator.lost_game()
			await get_tree().create_timer(10).timeout
			get_tree().reload_current_scene()


func spawn_character_randomly() -> void:
	if spawners.is_empty():
		return

	var random_spawner: Node3D = spawners.pick_random()
	random_spawner.spawn()
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)


func handle_blinking_q_button() -> void:
	while true:
		q.hide()
		await get_tree().create_timer(0.5).timeout
		q.show()
		await get_tree().create_timer(0.5).timeout


func _on_kill_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("people"):
		score -= 10
		body.die()


func _on_spawn_timer_timeout() -> void:
	spawn_character_randomly()
