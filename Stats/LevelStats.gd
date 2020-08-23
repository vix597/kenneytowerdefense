extends Stats

export(int) var money = 400 setget set_money

var current_round = 1 setget set_current_round
var current_level = null
var level_stats = {}

signal money_changed(value)
signal current_round_changed(value)


func set_current_round(value):
	current_round = clamp(value, 1, 999999)
	
	if self.current_level and self.level_stats.has(self.current_level.LEVEL_ID):
		self.level_stats[self.current_level.LEVEL_ID].max_rounds += 1
	
	emit_signal("current_round_changed", current_round)


func set_money(value):
	money = clamp(value, 0, 9999)
	emit_signal("money_changed", money)


func load_level(packed_scene):
	if self.current_level != null:
		self.current_level.queue_free()
	
	self.current_level = Utils.instance_scene_on_main(packed_scene)

	if not self.level_stats.has(self.current_level.LEVEL_ID):
		self.level_stats[self.current_level.LEVEL_ID] = {
			"max_rounds": self.current_round
		}


func save_data():
	return {
		"money": self.money,
		"current_round": self.current_round,
		"level_stats": self.level_stats
	}


func load_data(data):
	self.money = data.get("money", self.money)
	self.current_round = data.get("current_round", 1)
	self.level_stats = data.get("level_stats", {})
