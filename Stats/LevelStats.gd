extends Stats

export(int) var money = 400 setget set_money
export(int) var rounds = 3 setget set_rounds
export(int) var current_round = 1 setget set_current_round

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
