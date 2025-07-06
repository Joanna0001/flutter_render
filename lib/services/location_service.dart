import 'package:geolocator/geolocator.dart';

/// 一个封装了地理位置功能的静态服务类
class LocationService {
  /// 获取设备的当前位置。
  ///
  /// 这个方法会处理所有的流程：
  /// 1. 检查设备的位置服务是否开启。
  /// 2. 检查并请求应用的位置权限。
  /// 3. 获取并返回精确的地理位置。
  ///
  /// 如果过程中出现任何问题（如服务未开启、权限被拒绝），
  /// 此方法会抛出一个异常（Exception），方便调用方使用 `try-catch` 来处理。
  ///
  /// @return Future<Position> 成功时返回一个 Position 对象。
  /// @throws Exception 失败时抛出描述性错误。
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. 检查设备的位置服务是否已启用
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 如果位置服务被禁用，我们无法继续，直接抛出错误。
      // 在UI层，可以根据这个错误提示用户去设置中打开。
      return Future.error('位置服务已禁用，请在系统设置中开启。');
    }

    // 2. 检查应用的权限状态
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 如果权限被拒绝，则向用户发起请求
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 如果用户明确拒绝了这次请求，我们无法继续，抛出错误。
        return Future.error('您拒绝了位置权限，无法获取位置信息。');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 如果权限被永久拒绝（用户选择了"不再询问"），
      // 我们将无法再次请求权限，只能引导用户去应用设置中手动开启。
      return Future.error('位置权限已被永久拒绝，请在应用设置中手动开启。');
    }

    // 3. 当我们到达这里时，说明权限已经获取
    // 现在可以安全地获取设备的位置了。
    return await Geolocator.getCurrentPosition();
  }
}
