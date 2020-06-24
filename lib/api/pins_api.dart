import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/models.dart';

abstract class PinsApi {
  Future<List<Pin>> pins({int page});

  Future<Pin> pin({int id});

  Future<void> newPin({
    String title,
    String description,
    String url,
    bool isPrivate,
    Uint8List imageBytes,
    int boardId,
  });

  Future<Pin> editPin({int id, EditPin pin});

  Future<bool> deletePin({int id});
}

class DefaultPinsApi extends PinsApi {
  DefaultPinsApi(this._client);

  final ApiClient _client;

  @override
  Future<bool> deletePin({int id}) async {
    final response = await _client.delete('/pins/$id');
    return response.statusCode == 204;
  }

  @override
  Future<Pin> editPin({int id, EditPin pin}) async {
    final response = await _client.put(
      '/pins/$id',
      body: json.encode(pin),
    );
    return Pin.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
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

  @override
  Future<void> newPin({
    @required String title,
    @required String description,
    @required String url,
    @required bool isPrivate,
    @required Uint8List imageBytes,
    @required int boardId,
  }) async {
    final fields = {
      'title': title,
      'description': description,
      'url': url,
      'isPrivate': isPrivate.toString(),
    };

    try {
      await _client.fileUpload(
        '/boards/$boardId/pins',
        fields: fields,
        fileKey: 'image',
        fileBytes: imageBytes,
      );
    } on Exception {
      rethrow;
    }
  }
}
