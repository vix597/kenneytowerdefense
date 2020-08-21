extends Position2D
class_name EnemySpawner

export(Array, Dictionary) var SPAWN_RULES = [
	{
		"scene_path": "res://Enemies/Soldier.tscn",
		"quantity": 5
	}
]

export(float) var SPAWN_DELAY = 1.5
export(int) var SPREAD_RADIUS = 32

signal defeated()
signal all_spawned()
signal spawned(enemy)

var rule_idx = 0
var spawn_idx = 0
var dead = 0
var total_to_spawn = 0

onready var spawnDelay = $SpawnDelay


func _ready():
	for rule in SPAWN_RULES:
		total_to_spawn += rule.quantity


func spawn():
	dead = 0
	rule_idx = 0
	spawn_idx = 0
	spawn_next()
	spawnDelay.start(SPAWN_DELAY)


func spawn_one(path):
	var parent = get_parent()
	var point = get_next_spawn_point()
	var instance = load(path).instance()
	instance.global_position = point
	parent.add_child(instance)
	instance.connect("tree_exited", self, "_on_Enemy_tree_exited")
	emit_signal("spawned", instance)


func spawn_next():
	if rule_idx >= len(SPAWN_RULES):
		emit_signal("all_spawned")
		return

	var rule = SPAWN_RULES[rule_idx]
	spawn_one(rule.scene_path)
	spawn_idx += 1
	
	if spawn_idx >= rule.quantity:
		rule_idx += 1
		spawn_idx = 0
	
	spawnDelay.start(SPAWN_DELAY)

func get_next_spawn_point():
	var target_vector = Vector2(
		rand_range(-SPREAD_RADIUS, SPREAD_RADIUS),
		rand_range(-SPREAD_RADIUS, SPREAD_RADIUS)
	)
	return global_position + target_vector


func _on_Enemy_tree_exited():
	dead += 1
	if dead >= total_to_spawn:
		emit_signal("defeated")


func _on_SpawnDelay_timeout():
	spawn_next()
