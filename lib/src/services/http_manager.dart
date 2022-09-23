import 'package:dio/dio.dart';

class HttpManager {
  Future restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? boby,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'g1Oui3JqxnY4S1ykpQWHwEKGOe0dRYCPvPF4iykc',
        'X-Parse-REST-API-Key': 'rFBKU8tk0m5ZlKES2CGieOaoYz6TgKxVMv8jRIsN',
      });
    Dio dio = Dio();

    try {
      Response response = await dio.request(url,
          options: Options(
            headers: defaultHeaders,
            method: method,
          ),
          data: boby);
      return response.data;
    } on DioError catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }
}
