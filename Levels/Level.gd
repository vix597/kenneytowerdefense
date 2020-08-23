extends Node2D

signal level_complete()

export(String, FILE, "*.tscn") var NEXT_LEVEL_PATH = ""
export(bool) var FINAL_LEVEL = true
export(int) var NUM_ROUNDS = 3

onready var endPoint = $EndPoint
onready var enemySpawner = $EnemySpawner
onready var navigation = $Navigation2D


func _ready():
	LevelStats.current_level_path = filename
	LevelStats.rounds = NUM_ROUNDS
	LevelStats.current_round = 1
	next_round()


func next_round():
	enemySpawner.spawn()


func _on_EnemySpawner_spawned(enemy):
	var simple_path = navigation.get_simple_path(enemy.position, endPoint.position)
	enemy.nav_path = simple_path


func _on_Hurtbox_take_damage(area):
	LevelStats.health -= area.DAMAGE


func _on_EnemySpawner_defeated():
	if LevelStats.current_round < NUM_ROUNDS:
		LevelStats.current_round += 1
		next_round()
	else:
		emit_signal("level_complete")
