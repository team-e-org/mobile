import 'dart:convert';

import 'package:mobile/api/api_client.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mobile/model/pin_model.dart';

class EditUser {
  EditUser({
    this.name,
    this.email,
    this.icon,
  });

  final String name;
  final String email;
  final String icon;

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'icon': icon,
  };
}

abstract class UsersApi {
  Future<User> user({int id});

  Future<User> editUser({int id, EditUser user});

  Future<bool> deleteUser({int id});

  Future<List<Board>> userBoards({int id});

  Future<List<Pin>> userPins({int id});
}

class DefaultUsersApi extends UsersApi {
  DefaultUsersApi(this._client);

  final ApiClient _client;

  @override
  Future<bool> deleteUser({int id}) async {
    final response = await _client.delete("/users/$id");
    return response.statusCode == 204;
  }

  @override
  Future<User> editUser({int id, EditUser user}) async {
    final body = json.encode(user);
    print(body);
    final response = await _client.put(
      "/users/$id",
      body: body,
    );

    return User.fromJson(jsonDecode(response.body));
  }

  @override
  Future<User> user({int id}) async {
    final response = await _client.get("/users/$id");
    return User.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<Board>> userBoards({int id}) async {
    final response = await _client.get("/users/$id/boards");
    return (jsonDecode(response.body) as List)
        .map((it) => Board.fromJson(it))
        .toList();
  }

  @override
  Future<List<Pin>> userPins({int id}) async {
    final response = await _client.get("/users/$id/pins");
    return (jsonDecode(response.body) as List)
        .map((it) => Pin.fromJson(it))
        .toList();
  }
}