import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/common/utilities/constants/error_constants.dart';

class ApiHelper {
  Future<Dio> get _getDioObject async {
    return Dio(BaseOptions(
      baseUrl: "https://dog.ceo/",
      connectTimeout: Duration(seconds: _timeOut),
      receiveTimeout: Duration(seconds: _timeOut),
      responseType: ResponseType.json,
    ));
  }

  final int _timeOut = 20;

  Future<Map<String, dynamic>> getRequest(String url) async {
    try {
      Map<String, String> header = {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
        // You can add Authorization as below
        // "Authorization": "Bearer [accessToken]"
      };

      var dio = await _getDioObject;

      var response = await dio.get(
        url,
        options: Options(
          headers: header,
        ),
      );
      var result = response.data;
      if (result is Map<String, dynamic>) {
        return result;
      } else {
        throw Exception(defaultError);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw Exception(internetIssueError);
      } else {
        var result = e.response?.data;
        throw Exception(result.toString());
      }
    } on SocketException catch (_) {
      throw Exception(internetIssueError);
    } on IOException catch (_) {
      throw Exception(internetIssueError);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
