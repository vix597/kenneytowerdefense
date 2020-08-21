extends DefenseStructure

const CannonBall = preload("res://Projectile/CannonBall.tscn")
const LargeMuzzleFlash = preload("res://Effects/LargeMuzzleFlash.tscn")


func attack(enemy):
	var mzl_flash = LargeMuzzleFlash.instance()
	muzzle.add_child(mzl_flash)
	var direction = muzzle.global_position.direction_to(enemy.global_position)
	var cannon_ball = Utils.instance_scene_on_main(CannonBall, muzzle.global_position)
	cannon_ball.velocity = direction
