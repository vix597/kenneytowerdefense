extends Stats

export(int) var money = 400 setget set_money

var current_round = 1 setget set_current_round
var current_level_path = "res://Levels/Level_00.tscn"  # Set by level on load
var current_level = null
var rounds = 3 setget set_rounds  # Set by level on load

signal money_changed(value)
signal rounds_changed(value)
signal current_round_changed(value)


func set_current_round(value):
	current_round = clamp(value, 1, self.rounds)
	emit_signal("current_round_changed", current_round)


func set_rounds(value):
	rounds = clamp(value, 1, 999)
	emit_signal("rounds_changed", rounds)


func set_money(value):
	money = clamp(value, 0, 9999)
	emit_signal("money_changed", money)


func load_level(path):
	if self.current_level != null:
		self.current_level.queue_free()
	
	self.current_level_path = path
	self.current_level = Utils.instance_scene_on_main(load(self.current_level_path))
	self.current_level.connect("level_complete", self, "_on_LevelStats_level_complete")


func save_data():
	return {
		"money": self.money,
		"current_level_path": self.current_level_path,
		"current_round": self.current_round
	}


func load_data(data):
	self.money = data.get("money", self.money)
	self.current_round = data.get("current_round", 1)
	load_level(data.get("current_level_path", self.current_level_path))


func _on_LevelStats_level_complete():
	if not self.current_level.FINAL_LEVEL:
		load_level(self.current_level.NEXT_LEVEL_PATH)
