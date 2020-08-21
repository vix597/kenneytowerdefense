extends KinematicBody2D
class_name Projectile

export(int) var SPEED = 55

var velocity = Vector2.ZERO setget set_velocity

onready var sprite = $Sprite


func _physics_process(delta):
	sprite.flip_h = velocity.x < 0
	
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		velocity = Vector2.ZERO


func set_velocity(value):
	velocity = value * SPEED
	sprite.look_at(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Hitbox_area_entered(area):
	queue_free()  # Collided with hurtbox
