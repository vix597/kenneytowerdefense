extends KinematicBody2D
class_name Enemy

export(int) var MAX_SPEED = 150
export(int) var NAV_POINT_TARGET_RANGE = 4

var nav_path = PoolVector2Array()

onready var hurtbox = $Hurtbox
onready var sprite = $Sprite
onready var stats = $EnemyStats


func _physics_process(delta):
	if nav_path.size() == 0:
		return
	var move_amnt = MAX_SPEED * delta
	sprite.look_at(nav_path[0])
	move_along_path(move_amnt)


func move_along_path(move_amnt):
	var start_point = position
	var dist_to_next = start_point.distance_to(nav_path[0])
	if move_amnt > dist_to_next:
		move_amnt = dist_to_next
	
	position = start_point.move_toward(nav_path[0], move_amnt)
	
	if position.distance_to(nav_path[0]) <= NAV_POINT_TARGET_RANGE:
		nav_path.remove(0)


func _on_EnemyStats_no_health():
	queue_free()


func _on_Hurtbox_take_damage(area):
	stats.health -= area.DAMAGE


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
