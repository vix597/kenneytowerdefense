extends Node2D

onready var endPoint = $EndPoint
onready var enemySpawner = $EnemySpawner
onready var navigation = $Navigation2D


func _ready():
	enemySpawner.spawn()


func _on_EnemySpawner_spawned(enemy):
	var simple_path = navigation.get_simple_path(enemy.position, endPoint.position)
	enemy.nav_path = simple_path
