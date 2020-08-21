extends Node2D
class_name ConstructionZone

onready var singleCannonIcon = $SingleCannonIcon
onready var machineGunIcon = $MachineGunIcon


func _on_TextureButton_pressed():
	singleCannonIcon.toggle()
	machineGunIcon.toggle()


func _on_SingleCannonIcon_build(structure):
	Utils.instance_scene_on_main(load(structure), global_position)
	visible = false


func _on_MachineGunIcon_build(structure):
	Utils.instance_scene_on_main(load(structure), global_position)
	visible = false
