extends Area2D
class_name Hurtbox

signal take_damage(area)


func _on_Hurtbox_area_entered(area):
	if area is Hitbox:
		emit_signal("take_damage", area)
