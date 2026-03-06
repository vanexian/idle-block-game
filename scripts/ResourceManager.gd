extends Node
class_name ResourceManagerClass

static var gold_per_second: float = 0.0
static var diamond_per_minute: float = 0.0

static func update_production(buildings: Dictionary):
	var gps = 0.0
	var dpm = 0.0
	
	for building_id in buildings:
		var building = buildings[building_id]
		if building.has("gold_production"):
			gps += building.gold_production * building.get("level", 1)
		if building.has("diamond_production"):
			dpm += building.diamond_production * building.get("level", 1)
	
	gold_per_second = gps
	diamond_per_minute = dpm

static func get_gold_production():
	return gold_per_second

static func get_diamond_production():
	return diamond_per_minute
