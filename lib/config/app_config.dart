/// 定义应用可能运行的环境
enum Environment { development, production }

/// 一个持有特定环境配置信息的类
class AppConfig {
  final Environment environment;
  final String baseUrl;

  AppConfig({required this.environment, required this.baseUrl});
}

/// 存储所有环境的配置信息
/// key是环境枚举，value是该环境对应的配置对象
final Map<Environment, AppConfig> _configs = {
  Environment.development: AppConfig(
    environment: Environment.development,
    baseUrl: 'https://14.103.164.47', // 开发环境API (我们先用公共API做示例)
  ),
  Environment.production: AppConfig(
    environment: Environment.production,
    baseUrl: 'https://api.your-real-app.com/v1', // 生产环境API (未来替换成你真实的线上地址)
  ),
};

/// 'THE' 总开关
/// 只需要修改这一行，就能切换整个App的网络环境
/// 在开发阶段，我们使用 development.
/// 当你准备发布App时，需要把它改成 Environment.production.
AppConfig currentConfig = _configs[Environment.development]!;
