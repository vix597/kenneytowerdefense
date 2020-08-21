extends DefenseStructure

const Bullet = preload("res://Projectile/Bullet.tscn")
const SmallMuzzleFlash = preload("res://Effects/SmallMuzzleFlash.tscn")

var muzzles = []
var muzzle_idx = 0

onready var muzzle2 = $Body/Muzzle2

func _ready():
	muzzles.push_back(muzzle)
	muzzles.push_back(muzzle2)


func get_muzzle():
	var ret = muzzles[muzzle_idx]
	muzzle_idx += 1
	if muzzle_idx >= len(muzzles):
		muzzle_idx = 0
	return ret


func attack(enemy):
	var mzl = get_muzzle()
	var mzl_flash = SmallMuzzleFlash.instance()
	mzl.add_child(mzl_flash)
	var direction = mzl.global_position.direction_to(enemy.global_position)
	var bullet = Utils.instance_scene_on_main(Bullet, mzl.global_position)
	bullet.velocity = direction
