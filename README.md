# 🎮 色块工厂 (Idle Block Game)

一款休闲放置类建筑游戏，通过建设和升级各种建筑来获取资源。

## 📖 游戏说明

在《色块工厂》中，你将经营自己的工厂，通过：
- 🏗️ 建造各种生产建筑
- ⬆️ 升级建筑提高产量
- 💰 收集金币和钻石
- 🔄  prestige 系统解锁更多奖励

## 🎯 操作指南

### 基本操作
- **点击建筑**：查看建筑详情和升级选项
- **购买建筑**：消耗金币建造新建筑
- **升级建筑**：提高建筑的生产效率
- **收集资源**：点击资源面板收集金币

### 快捷键
- `S` - 保存游戏进度
- `L` - 加载游戏进度
- `R` - 重置游戏（需确认）

## 🏢 建筑列表

| 建筑名称 | 基础价格 | 生产效率 | 说明 |
|---------|---------|---------|------|
| 采矿场 | 100 金币 | 1 金币/秒 | 基础资源生产建筑 |
| 工厂 | 500 金币 | 5 金币/秒 | 中级生产建筑 |
| 科技中心 | 2000 金币 | 20 金币/秒 | 高级生产建筑 |
| 钻石矿 | 10000 金币 | 1 钻石/分钟 | 稀有资源生产 |

## 🛠️ 开发信息

### 技术栈
- **引擎**: Godot 4.2
- **语言**: GDScript
- **渲染**: Forward Plus

### 项目结构
```
idle-block-game/
├── project.godot          # 项目配置文件
├── export_presets.cfg     # 导出预设
├── run.sh                 # 启动脚本
├── README.md              # 项目文档
├── scenes/                # 场景文件
│   ├── Main.tscn         # 主场景
│   ├── Buildings/        # 建筑相关场景
│   └── UI/               # UI 场景
├── scripts/              # 脚本文件
│   └── GameManager.gd    # 游戏管理器
├── assets/               # 资源文件
│   └── sprites/          # 精灵图片
└── docs/                 # 文档
```

### 运行项目

```bash
# 使用启动脚本
./run.sh

# 或手动运行
cd /home/vane/.openclaw/workspace/projects/idle-block-game
godot --path . --editor
```

### 导出 Android 版本

1. 确保已配置 Android SDK 和 JDK
2. 创建签名密钥（如不存在）：
   ```bash
   keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore release.keystore -storepass android -validity 9999 -dname "CN=Android Debug,O=Android,C=US"
   ```
3. 在 Godot 编辑器中：项目 → 导出 → Android

### 待开发功能
- [ ] 更多建筑类型
- [ ] 成就系统
- [ ] 离线收益计算
- [ ] 音效和背景音乐
- [ ] 更多视觉效果

## 📄 许可证

MIT License

## 👥 开发团队

由 OpenClaw 代理团队开发
