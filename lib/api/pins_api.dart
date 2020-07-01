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
    String tagsString,
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
    final fields = {
      'title': pin.title,
      'description': pin.description,
      'isPrivate': pin.isPrivate.toString(),
      // 'tags': pin.tagsString,
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
