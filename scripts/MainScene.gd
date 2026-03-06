extends Node2D
class_name MainSceneClass

var game_manager
var resource_manager

@onready var gold_label = $UI/HSplitContainer/LeftPanel/ResourcePanel/MarginContainer/VBoxContainer/GoldLabel
@onready var diamond_label = $UI/HSplitContainer/LeftPanel/ResourcePanel/MarginContainer/VBoxContainer/DiamondLabel
@onready var dps_label = $UI/HSplitContainer/LeftPanel/ResourcePanel/MarginContainer/VBoxContainer/DPSLabel
@onready var building_list = $UI/HSplitContainer/LeftPanel/BuildingList

# 建筑配置
const BUILDING_CONFIGS = {
	"miner": {"name": "矿工", "color": Color(0.55, 0.27, 0.07), "base_cost": 10, "production": 1},
	"factory": {"name": "工厂", "color": Color(0.5, 0.5, 0.5), "base_cost": 100, "production": 5},
	"bank": {"name": "银行", "color": Color(1.0, 0.84, 0.0), "base_cost": 500, "production": 20},
	"lab": {"name": "实验室", "color": Color(0.0, 0.0, 1.0), "base_cost": 2000, "production": 50},
	"space": {"name": "太空站", "color": Color(0.5, 0.0, 0.5), "base_cost": 10000, "production": 200}
}

func _ready():
	# 创建游戏管理器
	game_manager = load("res://scripts/GameManager.gd").new()
	add_child(game_manager)
	
	# 创建资源管理器
	resource_manager = load("res://scripts/ResourceManager.gd").new()
	add_child(resource_manager)
	
	# 连接信号
	game_manager.resources_changed.connect(_on_resources_changed)
	
	# 初始化建筑
	init_buildings()
	
	# 更新显示
	update_resource_display()
	
	print("🎮 游戏启动成功!")
	print("🏗️ 建筑数量：%d" % BUILDING_CONFIGS.size())

func init_buildings():
	print("🏗️ 开始初始化建筑...")
	print("📋 建筑列表父节点：%s" % building_list)
	
	# 为每种建筑创建 UI 项
	for building_key in BUILDING_CONFIGS:
		var config = BUILDING_CONFIGS[building_key]
		
		# 创建建筑项
		var building_item = load("res://scenes/UI/BuildingItem.tscn").instantiate()
		
		if building_item and building_list:
			building_list.add_child(building_item)
			print("✅ 已添加建筑：%s" % config["name"])
			
			# 设置建筑数据
			building_item.init_building(
				building_key,
				config["name"],
				config["color"],
				config["base_cost"],
				config["production"]
			)
			
			# 连接升级信号
			building_item.upgrade_requested.connect(_on_building_upgrade)
		else:
			print("❌ 创建建筑失败！item=%s, list=%s" % [building_item, building_list])
	
	print("🏗️ 建筑初始化完成！子节点数：%d" % building_list.get_child_count())

func _on_building_upgrade(building_key: String):
	var config = BUILDING_CONFIGS[building_key]
	var cost = config["base_cost"] * int(pow(1.5, game_manager.buildings.get(building_key, 0)))
	
	if game_manager.gold >= cost:
		game_manager.gold -= cost
		game_manager.buildings[building_key] = game_manager.buildings.get(building_key, 0) + 1
		game_manager.emit_signal("resources_changed")
		print("⬆️ 升级 %s 到等级 %d" % [config["name"], game_manager.buildings[building_key]])
	else:
		print("❌ 金币不足！需要：%d" % cost)

func _on_resources_changed():
	update_resource_display()
	update_building_display()

func update_resource_display():
	if gold_label:
		gold_label.text = "💰 金币：%d" % game_manager.gold
	if diamond_label:
		diamond_label.text = "💎 钻石：%d" % game_manager.diamonds
	if dps_label:
		var dps = calculate_dps()
		dps_label.text = "⚡ 生产：%.1f/秒" % dps

func calculate_dps() -> float:
	var total_dps = 0.0
	for building_key in BUILDING_CONFIGS:
		var config = BUILDING_CONFIGS[building_key]
		var level = game_manager.buildings.get(building_key, 0)
		total_dps += config["production"] * level
	return total_dps

func update_building_display():
	# 更新所有建筑项的显示
	for building_item in building_list.get_children():
		if building_item.has_method("update_display"):
			building_item.update_display()

func _process(delta):
	# 自动生产资源
	var dps = calculate_dps()
	if dps > 0:
		game_manager.gold += int(dps * delta)
