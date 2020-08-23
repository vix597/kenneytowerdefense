extends Node2D

export(String) var LEVEL_ID = ""

var navigators = []

onready var endPoint = $EndPoint
onready var startPoint = $StartPoint
onready var enemySpawner = $EnemySpawner


func _ready():
	for child in get_children():
		if child is LevelNavigator:
			navigators.append(child)
	
	LevelStats.current_round = 1
	next_round()


func next_round():
	enemySpawner.spawn()


func get_navigator():
	navigators.shuffle()
	return navigators[0]


func _on_EnemySpawner_spawned(enemy):
	var nav = get_navigator()
	var simple_path = nav.get_simple_path(enemy.position, endPoint.position)
	enemy.nav_path = simple_path


func _on_Hurtbox_take_damage(area):
	LevelStats.health -= area.DAMAGE


func _on_EnemySpawner_defeated():
	LevelStats.current_round += 1
	next_round()
