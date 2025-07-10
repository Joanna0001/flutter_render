import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// 一个封装了地理位置功能的静态服务类
class LocationService {
  static Future<Position> determinePosition() async {
    try {
      // 1. 检查设备的位置服务是否已启用
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('位置服务已禁用，请在系统设置中开启。');
      }

      // 2. 检查应用的权限状态
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('您拒绝了位置权限，无法获取位置信息。');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error('位置权限已被永久拒绝，请在应用设置中手动开启。');
      }
      debugPrint('permission---------------: $permission');

      // 3. 当我们到达这里时，说明权限已经获取

      final LocationSettings locationSettings = AndroidSettings(
        accuracy: LocationAccuracy
            .high, //  android: hight medium low lowest   ios: lowest low medium high best
        forceLocationManager: true,
      );
      return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
    } catch (e) {
      debugPrint('error---------------: $e');
      return Future.error(e);
    }
  }
}
