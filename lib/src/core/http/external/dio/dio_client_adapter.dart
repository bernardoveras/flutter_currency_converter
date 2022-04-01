import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../errors/http_exception.dart';
import 'dio_response_adapter.dart';
import '../../infra/http_client.dart';
import '../../infra/http_response.dart';

class DioClientAdapter implements HttpClient {
  DioClientAdapter(this._dio) {
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false,
      ));
    }
  }

  final Dio _dio;

  @override
  Future<HttpResponse<T>> get<T>(String url, {Map<String, dynamic>? headers}) async {
    try {
      var result = await _dio.get(
        url,
        options: headers != null ? Options(headers: headers) : null,
      );

      return DioResponseAdapter.toHttpAdapter(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<HttpResponse<T>> post<T>(String url, {Map<String, dynamic>? headers, dynamic body}) async {
    try {
      var result = await _dio.post(
        url,
        data: jsonEncode(body),
        options: headers != null ? Options(headers: headers) : null,
      );

      return DioResponseAdapter.toHttpAdapter(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<HttpResponse<T>> put<T>(String url, {Map<String, dynamic>? headers, dynamic body}) async {
    try {
      var result = await _dio.put(
        url,
        data: jsonEncode(body),
        options: headers != null ? Options(headers: headers) : null,
      );

      return DioResponseAdapter.toHttpAdapter(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<HttpResponse<T>> delete<T>(String url, {Map<String, dynamic>? headers, dynamic body}) async {
    try {
      var result = await _dio.delete(
        url,
        data: jsonEncode(body),
        options: headers != null ? Options(headers: headers) : null,
      );

      return DioResponseAdapter.toHttpAdapter(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  Exception _handleException(dynamic exception) {
    if (exception is Exception) {
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.cancel:
            return HttpError(
              message: 'Request to API server was cancelled',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.serverError,
            );
          case DioErrorType.connectTimeout:
            return HttpError(
              message: 'Connection timeout with API server',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.timeout,
            );
          case DioErrorType.receiveTimeout:
            return HttpError(
              message: 'Receive timeout with API server',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.timeout,
            );
          case DioErrorType.response:
            switch (exception.response?.statusCode) {
              case 400:
                return HttpError(
                  message: 'Bad request',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.badRequest,
                );
              case 401:
                return HttpError(
                  message: 'Unauthorized',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.unauthorized,
                );
              case 403:
                return HttpError(
                  message: 'Forbidden',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.forbidden,
                );
              case 404:
                return HttpError(
                  message: 'Not found',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.notFound,
                );
              case 408:
                return HttpError(
                  message: 'Request timeout',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.timeout,
                );
              case 409:
                return HttpError(
                  message: 'Conflict',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.serverError,
                );
              case 500:
                return HttpError(
                  message: 'Internal server error',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.serverError,
                );
              case 503:
                return HttpError(
                  message: 'Service unavailable',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.serverError,
                );
              default:
                return HttpError(
                  message: exception.response?.statusMessage,
                  statusCode: exception.response?.statusCode,
                );
            }
          case DioErrorType.sendTimeout:
            return HttpError(
              message: 'Request timeout',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.timeout,
            );
          default:
            return HttpError(
              message: exception.response?.statusMessage,
              statusCode: exception.response?.statusCode,
            );
        }
      } else if (exception is SocketException) {
        return HttpError(
          errorType: HttpErrorType.noInternetConnection,
          message: 'No internet connection',
          statusCode: exception.osError?.errorCode,
        );
      }
    }

    return const HttpError(
      errorType: HttpErrorType.unexpected,
      message: 'Ocorreu um erro inesperado',
    );
  }
}
