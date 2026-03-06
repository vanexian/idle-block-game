extends Node
class_name GameManagerClass

signal resources_changed
signal building_upgraded

var gold: int = 0
var diamonds: int = 0
var prestige: int = 0
var buildings: Dictionary = {}
var last_save_time: int = 0

func _ready():
	load_game()

func add_gold(amount):
	gold += amount
	emit_signal("resources_changed")

func save_game():
	var save_data = {
		"gold": gold,
		"diamonds": diamonds,
		"buildings": buildings,
		"last_save": Time.get_unix_time_from_system()
	}
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))

func load_game():
	if FileAccess.file_exists("user://savegame.json"):
		var file = FileAccess.open("user://savegame.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		gold = data.get("gold", 0)
		# 计算离线收益
		calculate_offline_earnings(data.get("last_save", 0))

func calculate_offline_earnings(last_save: int):
	if last_save > 0:
		var elapsed_time = Time.get_unix_time_from_system() - last_save
		if elapsed_time > 0:
			var rm = load("res://scripts/ResourceManager.gd")
			var offline_earnings = elapsed_time * rm.gold_per_second
			gold += int(offline_earnings)
			emit_signal("resources_changed")
