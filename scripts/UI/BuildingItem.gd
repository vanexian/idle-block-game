extends PanelContainer
class_name BuildingItemClass

signal upgrade_requested(building_id: String)

var building_id: String
var building_name: String
var building_color: Color
var base_cost: int
var production: int
var level: int = 0

@onready var color_rect = $MarginContainer/HBoxContainer/ColorRect
@onready var name_label = $MarginContainer/HBoxContainer/VBoxContainer/NameLabel
@onready var level_label = $MarginContainer/HBoxContainer/VBoxContainer/LevelLabel
@onready var production_label = $MarginContainer/HBoxContainer/VBoxContainer/ProductionLabel
@onready var upgrade_button = $MarginContainer/HBoxContainer/VBoxContainer/UpgradeButton

func _ready():
	# 确保布局正确
	custom_minimum_size = Vector2(0, 80)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL

func init_building(id: String, name: String, color: Color, cost: int, prod: int):
	building_id = id
	building_name = name
	building_color = color
	base_cost = cost
	production = prod
	level = 0
	
	# 更新 UI
	color_rect.color = building_color
	name_label.text = building_name
	update_display()
	
	# 连接按钮信号
	upgrade_button.pressed.connect(_on_upgrade_button_pressed)

func update_display():
	level_label.text = "等级：%d" % level
	production_label.text = "生产：%d/秒" % (production * (level + 1))
	
	var current_cost = int(base_cost * pow(1.5, level))
	upgrade_button.text = "升级 (成本：%d)" % current_cost

func _on_upgrade_button_pressed():
	upgrade_requested.emit(building_id)

func update_level(new_level: int):
	level = new_level
	update_display()
