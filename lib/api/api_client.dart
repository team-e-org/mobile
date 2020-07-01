import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mobile/data/authentication_preferences.dart';

import 'errors/error.dart';

class ApiResponse {
  const ApiResponse(this.body, this.statusCode);

  factory ApiResponse.fromResponse(Response r) {
    return ApiResponse(
      utf8.decode(r.bodyBytes),
      r.statusCode,
    );
  }

  final int statusCode;
  final String body;
}

class ApiClient {
  const ApiClient(
    this._client, {
    @required this.apiEndpoint,
    @required this.prefs,
  });

  static const headerXAuthToken = 'x-auth-token';

  final String apiEndpoint;
  final Client _client;
  final AuthenticationPreferences prefs;

  Future<ApiResponse> get(String relativeUrl) async {
    final headers = await _headers;
    final getFuture = _client.get(
      '$apiEndpoint$relativeUrl',
      headers: headers,
    );

    return _makeRequestWithErrorHandler(getFuture);
  }

  Future<ApiResponse> post(String relativeUrl, {String body}) async {
    return _makeRequestWithErrorHandler(
      _client.post(
        '$apiEndpoint$relativeUrl',
        body: body,
        headers: await _headersContentTypeJson,
      ),
    );
  }

  Future<ApiResponse> put(String relativeUrl, {String body}) async {
    return _makeRequestWithErrorHandler(
      _client.put(
        '$apiEndpoint$relativeUrl',
        body: body,
        headers: await _headersContentTypeJson,
      ),
    );
  }

  Future<ApiResponse> delete(String relativeUrl) async {
    return _makeRequestWithErrorHandler(
      _client.delete(
        '$apiEndpoint$relativeUrl',
        headers: await _headers,
      ),
    );
  }

  Future<StreamedResponse> fileUpload(
    String relativeUrl, {
    Map<String, String> fields,
    String fileKey,
    Uint8List fileBytes,
  }) async {
    // Reference: https://pub.dev/documentation/http/latest/http/MultipartRequest-class.html
    final uri = Uri.parse('$apiEndpoint$relativeUrl');
    final request = MultipartRequest('POST', uri);
    request.fields.addAll(fields);
    request.files.add(MultipartFile.fromBytes(
      fileKey,
      fileBytes,
      filename: 'image.png', // FIXME: ファイルタイプをチェックするようにする
      contentType: MediaType.parse('image/png'),
    ));
    request.headers.addAll(await _headers);

    final response = await request.send();
    if (response.statusCode >= 400) {
      throw _handleError(
          response.statusCode,
          await response.stream.bytesToString(),
          response.request?.url?.toString());
    }
    return response;
  }

  Future<Map<String, String>> get _headers async {
    final result = <String, String>{};
    print(prefs.getAccessToken());
    result[headerXAuthToken] = prefs.getAccessToken();
    return result;
  }

  Future<Map<String, String>> get _headersContentTypeJson async {
    final result = await _headers;
    result['Content-Type'] = 'application/json';
    return result;
  }

  static Future<ApiResponse> _makeRequestWithErrorHandler(
      Future<Response> requestFunction) async {
    final response = await requestFunction;
    if (response.statusCode >= 400) {
      throw _handleError(response.statusCode, utf8.decode(response.bodyBytes),
          response.request?.url?.toString());
    }

    return ApiResponse.fromResponse(response);
  }

  static DefaultError _handleError(
    int statusCode,
    dynamic errorResponse,
    String url,
  ) {
    if (statusCode == 401) {
      return UnauthorizedError();
    } else if (statusCode == 403) {
      return ForbiddenServerError();
    } else if (statusCode == 404) {
      return NotFoundError(url);
    } else if (statusCode == 422) {
      return UnprocessableEntityError();
    } else if (statusCode >= 500 && statusCode <= 599) {
      return UnknownServerError(errorResponse, statusCode);
    } else {
      return UnknownClientError(errorResponse);
    }
  }
}
