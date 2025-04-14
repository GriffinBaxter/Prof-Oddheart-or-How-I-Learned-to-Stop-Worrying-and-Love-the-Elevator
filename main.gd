extends Node3D

@export var min_spawn_time: float
@export var max_spawn_time: float

var spawners: Array = [0]
var score: int = 0
var starting_money: int = 100

@onready var score_text: RichTextLabel = $UI/ScoreText
@onready var timer: Timer = $SpawnTimer


func _ready() -> void:
	score = starting_money
	score_text.text = "Moneys: $" + str(score)
	spawners = get_tree().get_nodes_in_group("spawners")

func _process(delta: float) -> void:
	pass

func spawn_character_randomly() -> void:
	if spawners.is_empty():
		return

	var random_spawner: Node3D = spawners.pick_random()
	random_spawner.spawn()
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)


func _on_kill_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("people"):
		score -= 10
		score_text.text = "Moneys: $" + str(score)
		body.die()


func _on_spawn_timer_timeout() -> void:
	spawn_character_randomly()
