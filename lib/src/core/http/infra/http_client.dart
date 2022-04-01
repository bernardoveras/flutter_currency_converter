import 'http_response.dart';

abstract class HttpClient {
  Future<HttpResponse<T>> get<T>(String url, {Map<String, dynamic>? headers});
  Future<HttpResponse<T>> post<T>(String url, {Map<String, dynamic>? headers, dynamic body});
  Future<HttpResponse<T>> put<T>(String url, {Map<String, dynamic>? headers, dynamic body});
  Future<HttpResponse<T>> delete<T>(String url, {Map<String, dynamic>? headers});
}
