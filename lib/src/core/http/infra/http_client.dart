import 'http_response.dart';

abstract class IHttpClient {
  Future<HttpResponse> get(String url, {Map<String, dynamic>? headers});
  Future<HttpResponse> post(String url, {Map<String, dynamic>? headers, dynamic body});
  Future<HttpResponse> put(String url, {Map<String, dynamic>? headers, dynamic body});
  Future<HttpResponse> delete(String url, {Map<String, dynamic>? headers});
}
