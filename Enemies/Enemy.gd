extends KinematicBody2D
class_name Enemy

export(int) var MAX_SPEED = 150
export(int) var NAV_POINT_TARGET_RANGE = 4
export(int) var HEALTH_RADIUS = 36
export(int) var HEALTH_BAR_HIDDEN_RADIUS = 20
export(Color) var HEALTH_COLOR = Color.green

var nav_path = PoolVector2Array()
var visible_radius = 0

onready var hurtbox = $Hurtbox
onready var sprite = $Sprite
onready var stats = $EnemyStats


func _ready():
	visible_radius = HEALTH_RADIUS - HEALTH_BAR_HIDDEN_RADIUS


func _draw():
	var radius = float(visible_radius) * stats.get_remaining_health_ratio()
	radius += HEALTH_BAR_HIDDEN_RADIUS

	var transform = get_transform()
	draw_circle(transform.xform_inv(position), radius, HEALTH_COLOR)


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
	update()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
