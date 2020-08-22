extends Node2D
class_name StructureIcon

signal build(structure)

enum {
	OPEN,
	CLOSE
}

export(String, FILE, "*.tscn") var TARGET_STRUCTURE = ""
export(int) var ICON_CIRCLE_RADIUS = 36
export(Color) var ICON_CIRCLE_COLOR = Utils.RGBA(15, 15, 15, 200)

var state = CLOSE

onready var animationPlayer = $AnimationPlayer


func _ready():
	visible = false


func _draw():
	var transform = get_transform()
	draw_circle(transform.xform_inv(position), ICON_CIRCLE_RADIUS, ICON_CIRCLE_COLOR)


func toggle():
	if state == OPEN:
		print("Close")
		close()
	else:
		print("Open")
		open()


func open():
	animationPlayer.play("Open")
	state = OPEN


func close():
	animationPlayer.play("Close")
	state = CLOSE


func _on_TextureButton_pressed():
	emit_signal("build", TARGET_STRUCTURE)
