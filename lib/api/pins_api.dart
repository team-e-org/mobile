import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/models.dart';

abstract class PinsApi {
  Future<RecommendPinResponse> getRecommendPins({String pagingKey});

  Future<List<Pin>> pins({int page});

  Future<Pin> pin({int id});

  Future<void> newPin({
    String title,
    String description,
    String url,
    bool isPrivate,
    String tagsString,
    Uint8List imageBytes,
    int boardId,
  });

  Future editPin({int id, EditPin pin});

  Future<bool> unsavePin({int boardId, int pinId});

  Future<bool> savePin({int pinId, int boardId});
}

class DefaultPinsApi extends PinsApi {
  DefaultPinsApi(this._client);

  final ApiClient _client;

  @override
  Future<bool> unsavePin({int boardId, int pinId}) async {
    final response = await _client.delete('/boards/$boardId/pins/$pinId');
    return response.statusCode == 204;
  }

  @override
  Future editPin({int id, EditPin pin}) async {
    final fields = {
      'title': pin.title,
      'description': pin.description,
      'isPrivate': pin.isPrivate.toString(),
      'tags': pin.tagsString,
    };

    await _client.fileUpload(
      'PUT',
      '/pins/$id',
      fields: fields,
    );
  }

  @override
  Future<Pin> pin({int id}) async {
    final response = await _client.get('/pins/$id');
    return Pin.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  @override
  Future<List<Pin>> pins({int page = 1}) async {
    final response = await _client.get('/pins?page=$page');
    return (jsonDecode(response.body) as List)
        .map((dynamic it) => Pin.fromJson(it as Map<String, dynamic>))
        .toList();
  }

  Future<bool> savePin({int pinId, int boardId}) async {
    final response = await _client.post('/boards/$boardId/pins/$pinId');
    return response.statusCode == 201;
  }

  @override
  Future<RecommendPinResponse> getRecommendPins({String pagingKey}) async {
    final body = json.encode({'pagingKey': pagingKey});
    print(body);
    final response = await _client.post('/pins', body: body);
    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    print('response.body');
    // print(response.body);
    return RecommendPinResponse(
      pins: (jsonBody['pins'] as List)
          .map((dynamic pin) => Pin.fromJson(pin as Map<String, dynamic>))
          .toList(),
      pagingKey: jsonBody['pagingKey'] as String,
    );
  }

  @override
  Future<void> newPin({
    @required String title,
    @required String description,
    @required String url,
    @required bool isPrivate,
    @required String tagsString,
    @required Uint8List imageBytes,
    @required int boardId,
  }) async {
    final fields = {
      'title': title,
      'description': description,
      'url': url,
      'isPrivate': isPrivate.toString(),
      'tags': tagsString,
    };

    await _client.fileUpload(
      'POST',
      '/boards/$boardId/pins',
      fields: fields,
      fileKey: 'image',
      fileBytes: imageBytes,
    );
  }
}

class RecommendPinResponse {
  RecommendPinResponse({this.pins, this.pagingKey});

  List<Pin> pins;
  String pagingKey;
}
