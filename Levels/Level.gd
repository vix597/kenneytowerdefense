extends Navigation2D

onready var endPoint = $EndPoint
onready var soldier = $Soldier


func _ready():
	var simple_path = get_simple_path(soldier.position, endPoint.position)
	soldier.nav_path = simple_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
