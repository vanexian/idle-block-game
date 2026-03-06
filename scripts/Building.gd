extends Node2D
class_name BuildingClass

@export var building_name: String
@export var base_cost: int = 10
@export var base_production: float = 1.0
@export var level: int = 0
@export var color: Color = Color.WHITE

func get_upgrade_cost() -> int:
	return int(base_cost * pow(1.5, level))

func get_production() -> float:
	return base_production * (level + 1)

func upgrade():
	if GameManager.gold >= get_upgrade_cost():
		GameManager.gold -= get_upgrade_cost()
		level += 1
		GameManager.emit_signal("building_upgraded")
