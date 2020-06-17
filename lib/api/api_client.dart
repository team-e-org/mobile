import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'errors/error.dart';

class ApiClient {
  static const headerXAuthToken = 'x-auth-token';

  final String apiEndpoint;
  final Client _client;

  // TODO トークンをshared_preferenceに保存するようになったら使う
  //  final AuthenticationPreferences _authenticationPreferences;

  ApiClient(
    this._client, {
    @required this.apiEndpoint,
  });

  Future<Response> get(String relativeUrl) async {
    return await _makeRequestWithErrorHandler(
      _client.get(
        '$apiEndpoint$relativeUrl',
        headers: await _headers,
      ),
    );
  }

  Future<Response> post(String relativeUrl, {String body}) async {
    return await _makeRequestWithErrorHandler(
      _client.post(
        '$apiEndpoint$relativeUrl',
        body: body,
        headers: await _headersContentTypeJson,
      ),
    );
  }

  Future<Response> put(String relativeUrl, {String body}) async {
    return await _makeRequestWithErrorHandler(
      _client.put(
        '$apiEndpoint$relativeUrl',
        body: body,
        headers: await _headersContentTypeJson,
      ),
    );
  }

  Future<Response> delete(String relativeUrl) async {
    return await _makeRequestWithErrorHandler(
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
    request.files.add(MultipartFile.fromBytes(fileKey, fileBytes));
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
    Map<String, String> result = {};

    // TODO: 実トークンを使う
    result[headerXAuthToken] = 'access_token';

    return result;
  }

  Future<Map<String, String>> get _headersContentTypeJson async {
    Map<String, String> result = await _headers;

    result['Content-Type'] = 'application/json';

    return result;
  }

  static Future<Response> _makeRequestWithErrorHandler(
      Future<Response> requestFunction) async {
    final Response response = await requestFunction;
    if (response.statusCode >= 400) {
      throw _handleError(response.statusCode, response.body,
          response.request?.url?.toString());
    }

    return response;
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
      return UnprocessableEntity();
    } else if (statusCode >= 500 && statusCode <= 599) {
      return UnknownServerError(errorResponse, statusCode);
    } else {
      return UnknownClientError(errorResponse);
    }
  }
}
