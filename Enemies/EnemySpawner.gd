extends Position2D
class_name EnemySpawner

enum EnemyType {
	SOLDIER,
	ROBOT
}

const Soldier = preload("res://Enemies/Soldier.tscn")
const Robot = preload("res://Enemies/Robot.tscn")

export(int) var ENEMIES_TO_SPAWN = 10
export(float) var SPAWN_DELAY = 1.5
export(int) var SPREAD_RADIUS = 48

signal defeated()
signal all_spawned()
signal spawned(enemy)

var dead = 0
var spawned = 0

onready var spawnDelay = $SpawnDelay


func spawn():
	dead = 0
	spawned = 0
	spawn_next()
	spawnDelay.start(SPAWN_DELAY)


func spawn_one(packed_scene):
	spawned += 1
	var parent = get_parent()
	var point = get_next_spawn_point()
	var instance = packed_scene.instance()
	instance.global_position = point
	parent.add_child(instance)
	instance.connect("tree_exited", self, "_on_Enemy_tree_exited")
	emit_signal("spawned", instance)


func spawn_next():
	if spawned >= ENEMIES_TO_SPAWN:
		emit_signal("all_spawned")
		return

	var which = int(rand_range(0, len(EnemyType)))
	
	match which:
		EnemyType.SOLDIER:
			spawn_one(Soldier)
		EnemyType.ROBOT:
			spawn_one(Robot)

	spawnDelay.start(SPAWN_DELAY)


func get_next_spawn_point():
	var target_vector = Vector2(
		rand_range(-SPREAD_RADIUS, SPREAD_RADIUS),
		rand_range(-SPREAD_RADIUS, SPREAD_RADIUS)
	)
	return global_position + target_vector


func _on_Enemy_tree_exited():
	dead += 1
	if dead >= ENEMIES_TO_SPAWN:
		print("defeated")
		emit_signal("defeated")


func _on_SpawnDelay_timeout():
	spawn_next()
