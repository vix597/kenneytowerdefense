extends Control

const level_00 = preload("res://Levels/Level_00.tscn")
const level_01 = preload("res://Levels/Level_01.tscn")


func _ready():
	SaveAndLoad.load_game()


func _on_Level_00_pressed():
	LevelStats.load_level(level_00)


func _on_Level_01_pressed():
	LevelStats.load_level(level_01)
