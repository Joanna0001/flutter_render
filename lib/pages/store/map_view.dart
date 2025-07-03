import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class StoreMapPage extends StatefulWidget {
  const StoreMapPage({super.key});

  @override
  State<StoreMapPage> createState() => _StoreMapPageState();
}

class _StoreMapPageState extends State<StoreMapPage> {
  // 地图控制器
  AMapController? _mapController;
  // 定位插件
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  // 当前位置
  LatLng? _currentLocation;
  // 标记点集合
  final Map<String, Marker> _markers = <String, Marker>{};
  // 监听器
  StreamSubscription<Map<String, Object>>? _locationListener;

  @override
  void initState() {
    super.initState();
    // 请求定位权限
    _requestPermission();
    // 设置定位监听
    _setupLocationListener();
  }

  // 请求定位权限
  Future<void> _requestPermission() async {
    // 请求位置权限
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    
    if (statuses[Permission.location]!.isGranted) {
      // 权限获取成功，开始定位
      _startLocation();
    } else {
      // 权限获取失败，提示用户
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('需要位置权限才能获取附近门店')),
      );
    }
  }

  // 设置定位监听
  void _setupLocationListener() {
    _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
      double? latitude = double.tryParse(result['latitude'].toString());
      double? longitude = double.tryParse(result['longitude'].toString());
      
      if (latitude != null && longitude != null) {
        setState(() {
          _currentLocation = LatLng(latitude, longitude);
          // 添加当前位置标记
          _addMarker(_currentLocation!, '当前位置');
          // 移动相机到当前位置
          _moveToCurrentLocation();
          // 模拟获取附近门店
          _getNearbyStores();
        });
      }
    });
  }

  // 开始定位
  void _startLocation() {
    // 设置定位参数
    _setLocationOption();
    // 启动定位
    _locationPlugin.startLocation();
  }

  // 设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();
    // 是否单次定位
    locationOption.onceLocation = false;
    // 定位间隔，单位毫秒
    locationOption.locationInterval = 10000;
    // 是否需要地址信息
    locationOption.needAddress = true;
    // 是否获取海拔高度
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    _locationPlugin.setLocationOption(locationOption);
  }

  // 添加标记点
  void _addMarker(LatLng position, String title, {bool isStore = false}) {
    final String markerId = '${position.latitude}_${position.longitude}';
    final Marker marker = Marker(
      position: position,
      infoWindow: InfoWindow(title: title),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        isStore ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
      ),
    );
    _markers[markerId] = marker;
  }

  // 移动相机到当前位置
  void _moveToCurrentLocation() {
    if (_currentLocation != null && _mapController != null) {
      _mapController!.moveCamera(
        CameraUpdate.newLatLngZoom(_currentLocation!, 15),
      );
    }
  }

  // 模拟获取附近门店
  void _getNearbyStores() {
    if (_currentLocation == null) return;
    
    // 模拟数据：附近门店位置
    final List<Map<String, dynamic>> nearbyStores = [
      {'name': '门店1', 'lat': _currentLocation!.latitude + 0.005, 'lng': _currentLocation!.longitude + 0.003, 'distance': '500m'},
      {'name': '门店2', 'lat': _currentLocation!.latitude - 0.002, 'lng': _currentLocation!.longitude + 0.006, 'distance': '800m'},
      {'name': '门店3', 'lat': _currentLocation!.latitude + 0.004, 'lng': _currentLocation!.longitude - 0.004, 'distance': '650m'},
    ];
    
    // 添加门店标记
    for (var store in nearbyStores) {
      _addMarker(
        LatLng(store['lat'], store['lng']),
        '${store['name']} (${store['distance']})',
        isStore: true,
      );
    }
    
    setState(() {});
  }

  @override
  void dispose() {
    // 停止定位
    _locationPlugin.stopLocation();
    // 移除定位监听
    _locationListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('附近门店'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AMapWidget(
              apiKey: const AMapApiKey(
                androidKey: '您的Android端高德地图Key',
                iosKey: '您的iOS端高德地图Key',
              ),
              initialCameraPosition: CameraPosition(
                target: LatLng(39.909187, 116.397451), // 默认北京位置
                zoom: 10.0,
              ),
              markers: Set<Marker>.of(_markers.values),
              onMapCreated: (AMapController controller) {
                _mapController = controller;
                if (_currentLocation != null) {
                  _moveToCurrentLocation();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
} 