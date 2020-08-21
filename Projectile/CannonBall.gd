extends Projectile

const ExplosionScar = preload("res://Effects/ExplosionScar.tscn")
const Explosion = preload("res://Effects/Explosion.tscn")

export(float) var LINGER_TIME = 0.45
export(float) var TRAVEL_TIME = 0.5

enum CannonBallState {
	TRAVEL,
	EXPLODE
}

var state = CannonBallState.TRAVEL setget set_state

onready var lingerTimer = $LingerTimer
onready var travelTimer = $LingerTimer
onready var explosionHitboxCollider = $ExplosionHitbox/Collider
onready var hitboxCollider = $Hitbox/Collider


func _ready():
	explosionHitboxCollider.disabled = true
	hitboxCollider.disabled = false
	travelTimer.start(TRAVEL_TIME)


func set_state(value):
	if state == CannonBallState.TRAVEL and value == CannonBallState.EXPLODE:
		lingerTimer.start(LINGER_TIME)
		hitboxCollider.disabled = true
		explosionHitboxCollider.disabled = false
		velocity = Vector2.ZERO
		sprite.visible = false
		Utils.instance_scene_on_main(ExplosionScar, global_position)
		Utils.instance_scene_on_main(Explosion, global_position)

	state = value


func _on_TravelTimer_timeout():
	self.state = CannonBallState.EXPLODE


func _on_Hitbox_area_entered(area):
	self.state = CannonBallState.EXPLODE


func _on_LingerTimer_timeout():
	queue_free()
