extends Node2D

export(String) var LEVEL_ID = ""

onready var endPoint = $EndPoint
onready var enemySpawner = $EnemySpawner
onready var navigation = $Navigation2D


func _ready():
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
	LevelStats.current_round += 1
	next_round()
