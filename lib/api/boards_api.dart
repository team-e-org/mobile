import 'dart:convert';

import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';

abstract class BoardsApi {
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
        .map((dynamic it) => Pin.fromJson(it as Map<String, dynamic>))
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
    return Board.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  @override
  Future<Board> newBoard({NewBoard board}) async {
    final response = await _client.post(
      "/boards",
      body: json.encode(board),
    );
    return Board.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
