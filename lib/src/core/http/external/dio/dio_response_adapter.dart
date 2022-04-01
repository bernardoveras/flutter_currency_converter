import 'dart:convert';

import 'package:dio/dio.dart';

import '../../infra/http_response.dart';

class DioResponseAdapter {
  const DioResponseAdapter._();

  static HttpResponse toHttpAdapter(Response response) {
    return HttpResponse(
      statusCode: response.statusCode,
      data: (response.data is String) ? jsonDecode(response.data) : response.data,
      statusMessage: response.statusMessage,
      headers: response.headers.map,
    );
  }
}
