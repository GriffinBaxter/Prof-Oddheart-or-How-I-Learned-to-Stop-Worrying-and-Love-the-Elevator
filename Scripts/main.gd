extends Node3D

const MAX_SCORE := 200.
const MIN_SCORE := -200.

const NEUTRAL_ARROW_COLOUR := Color.DIM_GRAY - Color(0, 0, 0, 0.5)
const GREEN_ARROW_COLOUR := Color("86ff4b")
const RED_ARROW_COLOUR := Color("ff413b")

@export var min_spawn_time: float
@export var max_spawn_time: float

var spawners: Array = [0]
var score: int = 0
var game_end := false

@onready var timer: Timer = $SpawnTimer
@onready var arrow_up: TextureRect = $UI/ArrowUp
@onready var arrow_down: TextureRect = $UI/ArrowDown
@onready var crowd_noise: AudioStreamPlayer = $CrowdNoise
@onready var game_lost: AudioStreamPlayer = $GameLost


func _ready() -> void:
	spawners = get_tree().get_nodes_in_group("spawners")


func _process(_delta: float) -> void:
	if !game_end:
		if score == 0:
			arrow_up.modulate = NEUTRAL_ARROW_COLOUR
			arrow_down.modulate = NEUTRAL_ARROW_COLOUR
		elif score > 0:
			arrow_up.modulate = (
				GREEN_ARROW_COLOUR * (score / MAX_SCORE)
				+ NEUTRAL_ARROW_COLOUR * ((MAX_SCORE - score) / MAX_SCORE)
			)
			arrow_down.modulate = NEUTRAL_ARROW_COLOUR
		elif score < 0:
			arrow_up.modulate = NEUTRAL_ARROW_COLOUR
			arrow_down.modulate = (
				RED_ARROW_COLOUR * (score / MIN_SCORE)
				+ NEUTRAL_ARROW_COLOUR * ((-MIN_SCORE + score) / -MIN_SCORE)
			)

		if score <= MIN_SCORE:
			game_end = true
			var elevator := get_tree().get_first_node_in_group("elevator")
			ElevatorMusic.stop()
			crowd_noise.stop()
			game_lost.play()
			elevator.set_lost_state()


func spawn_character_randomly() -> void:
	if spawners.is_empty():
		return

	var random_spawner: Node3D = spawners.pick_random()
	random_spawner.spawn()
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)


func _on_kill_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("people"):
		score -= 10
		body.die()


func _on_spawn_timer_timeout() -> void:
	spawn_character_randomly()
