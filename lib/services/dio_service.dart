import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_render/config/app_config.dart';

/// 一个封装了Dio的静态服务类
/// 提供了统一的网络请求功能，并包含了拦截器用于日志打印和未来的扩展。
class DioService {
  // 使用单例模式来管理Dio实例
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  late final Dio _dio;

  /// 私有构造函数，在这里进行Dio的初始化和配置
  DioService._internal() {
    // Dio的基础配置
    final BaseOptions options = BaseOptions(
      // 2. 从全局配置中读取baseUrl
      baseUrl: currentConfig.baseUrl,
      // 连接服务器超时时间，单位是毫秒.
      connectTimeout: const Duration(milliseconds: 10000),
      // 接收数据的总时限.
      receiveTimeout: const Duration(milliseconds: 10000),
      // 可以在这里配置统一的请求头
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Custom-Header': 'Your-Value',
      },
    );

    _dio = Dio(options);

    // 添加拦截器 (只在Debug模式下添加日志拦截器)
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true, // 打印请求体
          responseBody: true, // 打印响应体
          logPrint: (obj) => debugPrint(obj.toString()), // 使用debugPrint
        ),
      );
    }

    // 在这里还可以添加其他的拦截器，比如
    // - 处理Token刷新的拦截器
    // - 处理统一加载动画的拦截器
  }

  /// 发送GET请求
  ///
  /// [path] 请求的路径 (不需要包含baseUrl).
  /// [queryParameters] URL查询参数.
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      // DioException包含了Dio请求的所有错误信息
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('发生未知错误: $e');
    }
  }

  /// 发送POST请求
  ///
  /// [path] 请求的路径.
  /// [data] 请求体.
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('发生未知错误: $e');
    }
  }

  /// 发送PUT请求
  ///
  /// [path] 请求的路径.
  /// [data] 请求体.
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('发生未知错误: $e');
    }
  }

  /// 发送DELETE请求
  ///
  /// [path] 请求的路径.
  /// [data] 请求体.
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('发生未知错误: $e');
    }
  }

  /// 统一处理DioException
  Exception _handleDioException(DioException exception) {
    String errorMessage;
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = '连接超时，请检查您的网络。';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = '请求超时，请检查您的网络。';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = '响应超时，请检查您的网络。';
        break;
      case DioExceptionType.badResponse:
        // 服务器返回了非2xx的状态码
        final statusCode = exception.response?.statusCode;
        errorMessage = '服务器错误，状态码: $statusCode';
        break;
      case DioExceptionType.cancel:
        errorMessage = '请求已被取消。';
        break;
      case DioExceptionType.connectionError:
        errorMessage = '网络连接错误，请检查您的网络。';
        break;
      case DioExceptionType.unknown:
      default:
        errorMessage = '发生未知错误。';
        break;
    }
    return Exception(errorMessage);
  }
}
