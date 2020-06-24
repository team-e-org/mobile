import 'dart:convert';

import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/models.dart';

abstract class PinsApi {
  Future<List<Pin>> pins({int page});

  Future<Pin> pin({int id});

  Future<Pin> newPin({NewPin pin});

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
  Future<Pin> newPin({NewPin pin}) {
    // multipartリクエストが上手くいかないため保留
    // See: https://github.com/team-e-org/mobile/issues/49
    // TODO: implement newPin
    throw UnimplementedError();
  }
}
