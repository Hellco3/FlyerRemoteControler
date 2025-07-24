# Flyer Controller

## 项目简介

**Flyer Controller** 是一款基于 Flutter 的飞行器（如无人机）移动端控制应用。通过直观的虚拟摇杆和状态面板，用户可实时操控飞行器并获取关键飞行数据。项目采用组件化设计，支持多平台，易于扩展和维护。

## 功能特性

- 🎮 虚拟摇杆控制（全向/垂直）
- 📊 飞行状态实时显示（速度、角度等）
- 🔍 设备扫描与连接
- 🌗 主题切换（明暗模式）
- 🛠️ 自定义控制面板
- ⚡ 高效状态管理（GetX）
- 📱 跨平台支持（Android/iOS）

## 安装与运行

### 环境要求

- [Flutter](https://flutter.dev/) 3.x 及以上
- Dart 2.17 及以上
- Android Studio / Xcode（根据目标平台）

### 安装依赖

```bash
flutter pub get
```

### 运行项目

#### Android

```bash
flutter run
```

#### iOS

```bash
flutter run
```

> 如需生成 APK，请执行：
>
> ```bash
> flutter build apk
> ```

### 代码生成

如有使用注解（如 Freezed、JsonSerializable），请运行：

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 目录结构

```plaintext
lib/
  components/         # 组件目录（摇杆、指示器、按钮等）
  screens/            # 页面（控制页、设置页等）
  services/           # 服务与状态管理
  utilities/          # 工具类、常量、主题等
  main.dart           # 应用入口
assets/               # 静态资源（图标等）
test/                 # 测试用例
```

## 技术栈

- Flutter 3.x
- Dart 2.17+
- GetX（状态管理与路由）
- 组件化开发
- 响应式设计

## 贡献指南

欢迎提交 Issue 或 Pull Request 参与项目改进！

1. Fork 本仓库
2. 新建分支 (`git checkout -b feature/your-feature`)
3. 提交更改 (`git commit -am '添加新功能'`)
4. 推送分支 (`git push origin feature/your-feature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE)。
