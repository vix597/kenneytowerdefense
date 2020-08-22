extends Control

var money = 0 setget set_money
var health = 0 setget set_health
var rounds = 0 setget set_rounds
var current_round = 0 setget set_current_round

onready var moneyLabel = $MoneyLabel
onready var roundsLabel = $RoundsLabel
onready var healthLabel = $HealthLabel


func _ready():
	LevelStats.connect("money_changed", self, "_on_LevelStats_money_changed")
	LevelStats.connect("health_changed", self, "_on_LevelStats_health_changed")
	LevelStats.connect("rounds_changed", self, "_on_LevelStats_rounds_changed")
	LevelStats.connect("current_round_changed", self, "_on_LevelStats_current_round_changed")
	self.money = LevelStats.money
	self.health = LevelStats.health
	self.rounds = LevelStats.rounds
	self.current_round = LevelStats.current_round


func _on_LevelStats_money_changed(value):
	self.money = value


func _on_LevelStats_rounds_changed(value):
	self.rounds = value


func _on_LevelStats_health_changed(value):
	var ratio = LevelStats.get_remaining_health_ratio()
	var percent_remaining = ratio * 100.0
	self.health = int(percent_remaining)


func _on_LevelStats_current_round_changed(value):
	self.current_round = value


func set_rounds(value):
	rounds = value
	roundsLabel.text = str(current_round) + "/" + str(self.rounds)


func set_current_round(value):
	current_round = value
	roundsLabel.text = str(current_round) + "/" + str(self.rounds)


func set_money(value):
	money = value
	moneyLabel.text = "$" + str(money)


func set_health(value):
	health = value
	healthLabel.text = str(health) + "%"
