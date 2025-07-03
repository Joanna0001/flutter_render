import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AMapWebViewPage extends StatefulWidget {
  const AMapWebViewPage({super.key});

  @override
  State<AMapWebViewPage> createState() => _AMapWebViewPageState();
}

class _AMapWebViewPageState extends State<AMapWebViewPage> {
  late final WebViewController _controller;
  bool _isMapLoaded = false;
  String _loadingStatus = '加载中...';
  final List<Map<String, dynamic>> _storeList = [];

  @override
  void initState() {
    super.initState();
    _initWebView();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    
    if (statuses[Permission.location]!.isDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('需要位置权限才能获取附近门店')),
        );
      }
    }
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingStatus = '加载中... $progress%';
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _isMapLoaded = true;
            });
            // 地图加载完成后，初始化门店数据
            _initStoreData();
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _loadingStatus = '加载失败: ${error.description}';
            });
          },
        ),
      )
      ..addJavaScriptChannel(
        'Flutter',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJsMessage(message.message);
        },
      )
      ..loadHtmlString(_getHtmlContent());
  }

  String _getHtmlContent() {
    // 高德地图Web API的HTML内容
    return '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <title>高德地图</title>
        <style type="text/css">
          html, body, #container {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
          }
        </style>
        <script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=您的高德Web端Key"></script>
      </head>
      <body>
        <div id="container"></div>
        <script>
          var map, geolocation, currentPosition;
          var markers = [];
          
          // 初始化地图
          function initMap() {
            map = new AMap.Map('container', {
              resizeEnable: true,
              zoom: 15
            });
            
            // 添加定位控件
            map.plugin('AMap.Geolocation', function() {
              geolocation = new AMap.Geolocation({
                enableHighAccuracy: true,
                timeout: 10000,
                buttonPosition: 'RB',
                buttonOffset: new AMap.Pixel(10, 20),
                zoomToAccuracy: true,
              });
              map.addControl(geolocation);
              
              // 获取当前位置
              geolocation.getCurrentPosition(function(status, result) {
                if (status === 'complete') {
                  currentPosition = result.position;
                  // 通知Flutter已获取位置
                  Flutter.postMessage(JSON.stringify({
                    type: 'location',
                    latitude: currentPosition.lat,
                    longitude: currentPosition.lng
                  }));
                } else {
                  // 通知Flutter定位失败
                  Flutter.postMessage(JSON.stringify({
                    type: 'error',
                    message: '定位失败'
                  }));
                }
              });
            });
            
            // 添加比例尺控件
            map.plugin('AMap.Scale', function() {
              var scale = new AMap.Scale();
              map.addControl(scale);
            });
            
            // 点击地图事件
            map.on('click', function(e) {
              Flutter.postMessage(JSON.stringify({
                type: 'mapClick',
                latitude: e.lnglat.lat,
                longitude: e.lnglat.lng
              }));
            });
          }
          
          // 添加标记点
          function addMarker(id, latitude, longitude, title, iconUrl) {
            var marker = new AMap.Marker({
              position: new AMap.LngLat(longitude, latitude),
              title: title,
              icon: iconUrl || null,
              map: map
            });
            
            // 添加点击事件
            marker.on('click', function() {
              Flutter.postMessage(JSON.stringify({
                type: 'markerClick',
                id: id,
                title: title
              }));
            });
            
            markers.push({
              id: id,
              marker: marker
            });
            
            return marker;
          }
          
          // 清除所有标记点
          function clearMarkers() {
            for (var i = 0; i < markers.length; i++) {
              markers[i].marker.setMap(null);
            }
            markers = [];
          }
          
          // 计算两点之间的距离（米）
          function calculateDistance(lat1, lng1, lat2, lng2) {
            return AMap.GeometryUtil.distance([lng1, lat1], [lng2, lat2]);
          }
          
          // 初始化
          window.onload = initMap;
        </script>
      </body>
      </html>
    ''';
  }

  void _handleJsMessage(String message) {
    try {
      final data = jsonDecode(message);
      switch (data['type']) {
        case 'location':
          // 获取到用户位置后，可以加载附近门店
          _loadNearbyStores(data['latitude'], data['longitude']);
          break;
        case 'markerClick':
          // 处理门店标记点击事件
          _showStoreDetail(data['id'], data['title']);
          break;
        case 'error':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('错误: ${data['message']}')),
          );
          break;
      }
    } catch (e) {
      // print('JavaScript消息解析错误: $e');
    }
  }

  // 模拟加载附近门店数据
  void _loadNearbyStores(double latitude, double longitude) {
    // 模拟数据，实际项目中应该从API获取
    final stores = [
      {'id': '1', 'name': '门店1', 'lat': latitude + 0.005, 'lng': longitude + 0.003},
      {'id': '2', 'name': '门店2', 'lat': latitude - 0.002, 'lng': longitude + 0.006},
      {'id': '3', 'name': '门店3', 'lat': latitude + 0.004, 'lng': longitude - 0.004},
      {'id': '4', 'name': '门店4', 'lat': latitude - 0.003, 'lng': longitude - 0.002},
    ];
    
    setState(() {
      _storeList.clear();
      _storeList.addAll(stores);
    });
    
    // 在地图上添加门店标记
    for (var store in stores) {
      _addStoreMarker(store);
    }
  }

  // 添加门店标记
  void _addStoreMarker(Map<String, dynamic> store) {
    final jsCode = '''
      addMarker('${store['id']}', ${store['lat']}, ${store['lng']}, '${store['name']}');
    ''';
    _controller.runJavaScript(jsCode);
  }

  // 初始化门店数据
  void _initStoreData() {
    final jsCode = '''
      geolocation.getCurrentPosition();
    ''';
    _controller.runJavaScript(jsCode);
  }

  // 显示门店详情
  void _showStoreDetail(String id, String title) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('门店ID: $id'),
              const SizedBox(height: 16),
              const Text('营业时间: 09:00 - 22:00'),
              const SizedBox(height: 8),
              const Text('联系电话: 400-123-4567'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // 这里可以跳转到下单页面
                  },
                  child: const Text('去下单'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('附近门店'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isMapLoaded ? _initStoreData : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (!_isMapLoaded)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(_loadingStatus),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // 门店列表
          Container(
            height: 120,
            color: Colors.white,
            child: _storeList.isEmpty
                ? const Center(child: Text('加载门店中...'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _storeList.length,
                    itemBuilder: (context, index) {
                      final store = _storeList[index];
                      return GestureDetector(
                        onTap: () => _showStoreDetail(store['id'], store['name']),
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(25),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('营业中'),
                              const Spacer(),
                              const Text(
                                '点击查看详情',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
