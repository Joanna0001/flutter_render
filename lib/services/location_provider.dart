// lib/services/location_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_render/models/location_data.dart';
import 'package:flutter_render/services/amap_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location_service.dart'; // 获取原始坐标

class LocationProvider with ChangeNotifier {
  LocationData? _currentLocation;
  String? _errorMessage;
  bool _isLoading = false;
  final AmapService _amapService = AmapService(); // 持有一个 AmapService 的实例

  // 对外暴露的getters，UI通过它们来读取状态
  LocationData? get currentLocation => _currentLocation;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  /// 构造函数中，尝试从本地存储加载上一次的位置信息
  LocationProvider() {
    _loadLastKnownLocation();
  }

  /// 从 SharedPreferences 中加载位置
  Future<void> _loadLastKnownLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble('last_latitude');
    final lon = prefs.getDouble('last_longitude');
    final address = prefs.getString('last_address');

    if (lat != null && lon != null) {
      _currentLocation = LocationData(
        latitude: lat,
        longitude: lon,
        address: address,
      );
      notifyListeners(); // 通知UI更新
    }
  }

  /// 将位置信息保存到 SharedPreferences
  Future<void> _saveLocation(LocationData location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('last_latitude', location.latitude);
    await prefs.setDouble('last_longitude', location.longitude);
    if (location.address != null) {
      await prefs.setString('last_address', location.address!);
    } else {
      // 如果地址为空，也应该移除旧的地址
      await prefs.remove('last_address');
    }
  }

  /// 获取当前位置的完整流程
  Future<void> fetchCurrentLocation() async {
    if (_isLoading) return; // 防止重复请求

    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // 通知 UI 开始加载

    try {
      final position = await LocationService.determinePosition();

      _currentLocation = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        // 暂时保留旧地址，避免闪烁
        address: _currentLocation?.address,
      );

      notifyListeners();

      // 第2步: 使用 AmapService 将坐标逆地理编码为地址
      final address = await _amapService.getAddress(
        position.latitude,
        position.longitude,
      );

      // 第3步: 更新状态，包含新的地址
      _currentLocation = _currentLocation?.copyWith(address: address);

      // 第4步: 将包含地址的完整信息持久化到本地
      if (_currentLocation != null) {
        await _saveLocation(_currentLocation!);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
