extends Area2D

var bodies_in_view = []


func can_see_body():
	return len(bodies_in_view) > 0


func get_first_body():
	if len(bodies_in_view) > 0:
		return bodies_in_view[0]
	return null


func _on_DetectionZone_body_entered(body):
	bodies_in_view.push_back(body)


func _on_DetectionZone_body_exited(body):
	var idx = bodies_in_view.find(body)
	if idx != -1:
		bodies_in_view.remove(idx)
