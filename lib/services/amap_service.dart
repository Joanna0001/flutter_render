import 'package:dio/dio.dart';
import 'package:flutter_render/services/dio_service.dart';

/// 一个专门负责与高德地图API交互的服务类。
class AmapService {
  final String _apiKey = 'ce1ecb89b0657be6dbc4599de49ae395';

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
      final Response response = await DioService().get(
        fullUrl,
        queryParameters: params,
      );

      final Map<String, dynamic> data = response.data;

      if (data['status'] == '1' && data['regeocode'] != null) {
        return data['regeocode']['formatted_address'];
      } else {
        throw Exception('高德API返回错误: ${data['info']}');
      }
    } on Exception catch (e) {
      throw Exception('请求高德API失败: $e');
    }
  }
}
