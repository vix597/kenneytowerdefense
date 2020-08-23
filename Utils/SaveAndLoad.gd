extends Node

const SAVE_DATA_PATH = "user://kenney_tower_defense_save_data.json"

var save_data = null


func save_game():
	var save_data = LevelStats.save_data()
	_save_data_to_file(save_data)
	return save_data


func load_game():
	save_data = _load_data_from_file()
	if save_data == null:
		save_data = save_game()  # Create initial save

	LevelStats.load_data(save_data)


func _save_data_to_file(data):
	"""
	Write a file with the current save data
	
	:param save_data: Data to save to the file
	"""
	var json_string = to_json(data)
	var save_file = File.new()
	save_file.open(SAVE_DATA_PATH, File.WRITE)
	save_file.store_line(json_string)
	save_file.close()


func _load_data_from_file():
	"""
	Load save data from our save location
	
	:returns: The loaded save data or the default save data if a new game.
	"""
	var save_file = File.new()
	if not save_file.file_exists(SAVE_DATA_PATH):
		return null
		
	save_file.open(SAVE_DATA_PATH, File.READ)
	var data = parse_json(save_file.get_as_text())
	save_file.close()
	return data
