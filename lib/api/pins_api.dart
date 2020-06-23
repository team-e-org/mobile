import 'dart:convert';

import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/models.dart';

abstract class PinsApi {
  Future<List<Pin>> pins({int page});

  Future<Pin> pin({int id});

  Future<void> newPin({NewPin newPin, Board board});

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
  Future<void> newPin({NewPin newPin, Board board}) async {
    final fields = {
      'title': newPin.title,
      'description': newPin.description,
      'url': newPin.url,
      'isPrivate': newPin.isPrivate.toString(),
    };
    final fileBytes = base64.decode(newPin.image);

    try {
      await _client.fileUpload(
        '/boards/${board.id}/pins',
        fields: fields,
        fileKey: 'image',
        fileBytes: fileBytes,
      );
    } on Exception {
      rethrow;
    }
  }
}
