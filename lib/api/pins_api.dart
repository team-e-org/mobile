import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/models.dart';

class NewPin {
  NewPin({
    @required this.title,
    @required this.image,
    this.description,
    this.url,
    this.isPrivate,
  });

  final String title;
  final String description;
  final String url;
  final bool isPrivate;
  final String image;
}

class EditPin {
  EditPin({
    this.title,
    this.description,
    this.isPrivate,
  });

  final String title;
  final String description;
  final bool isPrivate;
}

abstract class PinsApi {
  Future<List<Pin>> pins({int page});

  Future<Pin> pin(int id);

  Future<Pin> newPin({NewPin pin});

  Future<bool> editPin(EditPin pin);

  Future<bool> deletePin(int id);
}

class DefaultPinsApi extends PinsApi {
  DefaultPinsApi(this._client);

  final ApiClient _client;

  @override
  Future<bool> deletePin(int id) async {
    final response = await _client.delete("/pins/$id");
    return response.statusCode == 204;
  }

  @override
  Future<bool> editPin(EditPin pin) {
    // TODO: API仕様変更中のためいったん保留
    throw UnimplementedError();
  }

  @override
  Future<Pin> pin(int id) async {
    final response = await _client.get("/pins/$id");
    return Pin.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<Pin>> pins({int page = 1}) async {
    final response = await _client.get("/pins?page=$page");
    return (jsonDecode(response.body) as List)
        .map((it) => Pin.fromJson(it))
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