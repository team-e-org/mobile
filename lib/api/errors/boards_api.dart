import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';

class NewBoard {
  NewBoard({
    @required this.name,
    this.description,
    @required this.isPrivate,
  });

  String name;
  String description;
  bool isPrivate;

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description ?? '',
        'isPrivate': isPrivate,
      };
}

class EditBoard {
  EditBoard({
    this.name,
    this.description,
    this.isPrivate,
    this.isArchive,
  });

  String name;
  String description;
  bool isPrivate;
  bool isArchive;

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'isPrivate': isPrivate,
        'isArchive': isArchive
      };
}

abstract class BoardsApi {
  Future<List<Board>> boards();

  Future<Board> newBoard({NewBoard board});

  Future<bool> deleteBoard({int id});

  Future<Board> editBoard({int id, EditBoard board});

  Future<List<Pin>> boardPins({int id, int page});
}

class DefaultBoardsApi extends BoardsApi {
  DefaultBoardsApi(this._client);

  final ApiClient _client;

  @override
  Future<List<Pin>> boardPins({int id, int page = 1}) async {
    final response = await _client.get("/boards/$id/pins?page=$page");
    return (jsonDecode(response.body) as List)
        .map((it) => Pin.fromJson(it))
        .toList();
  }

  @override
  Future<List<Board>> boards() async {
    final response = await _client.get("/boards");
    return (jsonDecode(response.body) as List)
        .map((it) => Board.fromJson(it))
        .toList();
  }

  @override
  Future<bool> deleteBoard({int id}) async {
    final response = await _client.delete("/boards/$id");
    return response.statusCode == 204;
  }

  @override
  Future<Board> editBoard({int id, EditBoard board}) async {
    final response = await _client.put(
      '/boards/$id',
      body: json.encode(board),
    );
    return Board.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Board> newBoard({NewBoard board}) async {
    final body = json.encode(board);
    print(body);
    final response = await _client.post(
      "/boards",
      body: body,
    );
    return Board.fromJson(jsonDecode(response.body));
  }
}
