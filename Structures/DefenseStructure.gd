extends StaticBody2D
class_name DefenseStructure

signal sold(value)

export(int) var STRUCTURE_VALUE = 50
export(float) var ATTACK_COOLDOWN_TIME = 0.25

enum StructureState {
	SEARCH,
	DESTROY
}

var state = StructureState.SEARCH

onready var baseSprite = $Base
onready var bodySprite = $Body
onready var enemyDetector = $EnemyDetectionZone
onready var muzzle = $Body/Muzzle
onready var attackCooldown = $AttackCooldown
onready var sellIcon = $SellIcon


func _physics_process(delta):
	match state:
		StructureState.SEARCH:
			seek_enemy()
		StructureState.DESTROY:
			var enemy = enemyDetector.get_first_body()
			if enemy != null:
				bodySprite.look_at(enemy.global_position)
				if attackCooldown.time_left == 0:
					attackCooldown.start(ATTACK_COOLDOWN_TIME)
					attack(enemy)


func attack(enemy):
	pass  # Implement this in sub-classes


func seek_enemy():
	if enemyDetector.can_see_body():
		state = StructureState.DESTROY


func _on_TextureButton_pressed():
	sellIcon.toggle()


func _on_SellIcon_icon_clicked(structure):
	emit_signal("sold", STRUCTURE_VALUE)
	queue_free()
