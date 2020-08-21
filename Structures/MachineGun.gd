extends DefenseStructure

const Bullet = preload("res://Projectile/Bullet.tscn")
const SmallMuzzleFlash = preload("res://Effects/SmallMuzzleFlash.tscn")


func attack(enemy):
	Utils.instance_scene_on_main(SmallMuzzleFlash, muzzle.global_position)
	var direction = muzzle.global_position.direction_to(enemy.global_position)
	var bullet = Utils.instance_scene_on_main(Bullet, muzzle.global_position)
	bullet.velocity = direction
