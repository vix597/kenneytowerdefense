extends Node2D
class_name ConstructionZone

onready var singleCannonIcon = $SingleCannonIcon
onready var machineGunIcon = $MachineGunIcon


func toggle():
	singleCannonIcon.toggle()
	machineGunIcon.toggle()


func _on_TextureButton_pressed():
	toggle()


func _on_SingleCannonIcon_icon_clicked(structure):
	if LevelStats.money >= singleCannonIcon.COST:
		LevelStats.money -= singleCannonIcon.COST
	else:
		return

	var inst = Utils.instance_scene_on_main(load(structure), global_position)
	inst.connect("sold", self, "_on_Structure_sold")
	toggle()
	visible = false


func _on_MachineGunIcon_icon_clicked(structure):
	if LevelStats.money >= machineGunIcon.COST:
		LevelStats.money -= machineGunIcon.COST
	else:
		return

	var inst = Utils.instance_scene_on_main(load(structure), global_position)
	inst.connect("sold", self, "_on_Structure_sold")
	toggle()
	visible = false


func _on_Structure_sold(value):
	LevelStats.money += value
	visible = true
