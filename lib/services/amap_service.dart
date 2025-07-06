import 'package:dio/dio.dart';
import 'package:flutter_render/services/dio_service.dart';

/// 一个专门负责与高德地图API交互的服务类。
class AmapService {
  // 重要的提示：
  // 1. 你需要去高德开放平台注册一个账号，创建一个应用。
  // 2. 获取一个 "Web服务" 类型的Key。
  // 3. 把下面这个Key替换成你自己的。
  final String _apiKey = 'ce1ecb89b0657be6dbc4599de49ae395';

  /// 根据经纬度坐标，调用高德逆地理编码API来获取格式化的地址字符串。
  ///
  /// [latitude] 纬度.
  /// [longitude] 经度.
  /// @return Future<String> 成功时返回地址，失败时抛出异常。
  Future<String> getAddress(double latitude, double longitude) async {
    // 高德逆地理编码API的URL
    const String fullUrl = 'https://restapi.amap.com/v3/geocode/regeo';

    // 准备请求参数
    final Map<String, dynamic> params = {
      'key': _apiKey,
      'location': '$longitude,$latitude',
      'output': 'json',
      'extensions': 'base',
    };

    try {
      // 使用我们强大的DioService来发送请求
      final Response response = await DioService().get(
        fullUrl,
        queryParameters: params,
      );

      final Map<String, dynamic> data = response.data;

      // 根据高德API文档，检查返回状态是否成功
      if (data['status'] == '1' && data['regeocode'] != null) {
        // 返回格式化后的地址
        return data['regeocode']['formatted_address'];
      } else {
        // 如果高德API返回错误，则抛出异常
        throw Exception('高德API返回错误: ${data['info']}');
      }
    } on Exception catch (e) {
      // 重新抛出DioService的错误或上面的业务错误，让上层能捕获
      throw Exception('请求高德API失败: $e');
    }
  }
}
