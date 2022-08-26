import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptor.dart';
import 'package:quotes/core/api/end_point.dart';
import 'package:quotes/core/api/status_code.dart';
import 'package:quotes/core/error/exception.dart';
import 'package:quotes/core/services/service_locator.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..receiveDataWhenStatusError = false
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(sl<AppInterceptor>());
    if (kDebugMode) {
      client.interceptors.add(sl<LogInterceptor>());
    }
  }

  @override
  Future get({required String path, Map<String, dynamic>? query}) async {
    try {
      return await client.get(path, queryParameters: query);
    } on DioError catch (error) {
      _handleError(error);
    }
  }

  @override
  Future post(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    try {
      return await client.post(path, queryParameters: query, data: data);
    } on DioError catch (error) {
      _handleError(error);
    }
  }

  @override
  Future put(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    try {
      return await client.put(path, queryParameters: query, data: data);
    } on DioError catch (error) {
      _handleError(error);
    }
  }

  dynamic _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }
}
