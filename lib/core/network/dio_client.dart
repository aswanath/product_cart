import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options.responseType = ResponseType.json;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
      );
    } catch (e) {
      return null;
    }
  }
}
