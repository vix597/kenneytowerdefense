extends Sprite

onready var animationPlayer = $AnimationPlayer


func _on_AnimationPlayer_animation_finished(anim_name):
	animationPlayer.play("FadeOut")
