# 🌐 在线打包指南 - 色块工厂

由于 Godot 4.2/4.4 在本地系统上存在兼容性问题，我们提供以下在线构建方案。

---

## 方案 A：GitHub Actions（推荐）⭐

### 步骤

#### 1. 创建 GitHub 仓库

```bash
cd /home/vane/.openclaw/workspace/projects/idle-block-game
git init
git add .
git commit -m "Initial commit - Idle Block Game"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/idle-block-game.git
git push -u origin main
```

#### 2. 启用 GitHub Actions

- 访问：https://github.com/YOUR_USERNAME/idle-block-game/actions
- 点击 **"I understand my workflows, go ahead and enable them"**

#### 3. 触发构建

- 推送代码会自动触发构建
- 或手动触发：Actions → "Godot Android Build" → "Run workflow"

#### 4. 下载 APK

- 构建完成后，在 Actions 页面找到最新运行
- 滚动到底部 **"Artifacts"**
- 下载 `android-apk.zip`

---

## 方案 B：使用 Docker 本地构建

### 使用 Godot CI 镜像

```bash
cd /home/vane/.openclaw/workspace/projects/idle-block-game

# 拉取 Godot 4.4 CI 镜像
docker pull barichello/godot-ci:4.4

# 运行构建
docker run --rm \
  -v "$(pwd):/github/workspace" \
  -w /github/workspace \
  barichello/godot-ci:4.4 \
  godot --headless --export-release "Android" build/idle-block-game.apk
```

---

## 方案 C：W4 Games 专业服务

W4 Games 是 Godot 创始团队创办的企业服务公司，提供：
- 专业构建服务
- 平台移植（Android/iOS/主机）
- 性能优化

访问：https://www.w4games.com/

---

## 方案 D：其他在线服务

### Buildbox
- https://www.buildbox.com/
- 支持 Godot 项目
- 免费套餐有限制

### PlayEveryWare
- https://playeveryware.com/
- 专业游戏移植服务
- 支持多平台

---

## 📋 构建前检查清单

### 必需文件

- [x] `project.godot` - 项目配置
- [x] `export_presets.cfg` - 导出预设
- [x] `scenes/Main.tscn` - 主场景
- [x] `scripts/*.gd` - 游戏脚本
- [x] `assets/sprites/*.png` - 美术资源

### 导出配置检查

```bash
# 验证导出预设
cat export_presets.cfg | grep -A 5 "preset.0"

# 应该包含:
# - package/unique_name="com.idle.blockgame"
# - package/signed=true
# - keystore/release="..."
```

### 签名密钥

确保 `release.keystore` 文件存在：
```bash
ls -la release.keystore
# 应该显示文件信息
```

---

## 🔧 故障排除

### 问题：GitHub Actions 构建失败

**错误**: `No export template found`

**解决**: 在 workflow 中添加模板复制步骤：
```yaml
- name: Import templates
  run: |
    mkdir -p ~/.local/share/godot/export_templates
    cp -r /root/.local/share/godot/export_templates/4.4.stable ~/.local/share/godot/export_templates/
```

### 问题：APK 签名失败

**错误**: `Keystore was not found`

**解决**: 在 GitHub Secrets 中添加密钥文件：
1. 仓库 → Settings → Secrets and variables → Actions
2. 添加 `KEYSTORE_FILE`（上传 release.keystore 的 base64）
3. 添加 `KEYSTORE_PASSWORD`（密码）
4. 添加 `KEYSTORE_ALIAS`（别名）

---

## 📱 安装测试

### 通过 ADB 安装

```bash
# 下载 APK 后
adb install -r idle-block-game.apk

# 启动游戏
adb shell am start -n com.idle.blockgame/org.godotengine.godot.Godot
```

### 直接传输到手机

1. 通过 USB 传输 APK 文件
2. 在手机上点击安装
3. 启用"未知来源"权限（如果需要）

---

## 🎯 推荐流程

```
本地开发 → Git 提交 → GitHub Actions → 下载 APK → ADB 安装测试
```

这个流程完全避开了本地 Godot 编辑器的问题！

---

## 📞 需要帮助？

- Godot 官方文档：https://docs.godotengine.org/
- Godot 社区：https://godotengine.org/community/
- GitHub Actions 文档：https://docs.github.com/en/actions
