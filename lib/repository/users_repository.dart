import 'package:mobile/api/users_api.dart';
import 'package:mobile/model/models.dart';

abstract class UsersRepository {
  Future<User> getUser(int id) async {}
  Future<List<Board>> getUserBoards(int id) async {}
}

class DefaultUsersRepository extends UsersRepository {
  factory DefaultUsersRepository(UsersApi api) {
    return _instance ?? DefaultUsersRepository._internal(api);
  }

  DefaultUsersRepository._internal(this._api);

  static DefaultUsersRepository _instance;
  UsersApi _api;

  Future<User> getUser(int id) async {
    return _api.user(id: id);
  }

  Future<List<Board>> getUserBoards(int id) async {
    return _api.userBoards(id: id);
  }
}

class MockUsersRepository extends UsersRepository {
  factory MockUsersRepository() {
    return _instance ?? MockUsersRepository._internal();
  }

  MockUsersRepository._internal();

  static MockUsersRepository _instance;

  Future<User> getUser(int id) async {
    return User.fromMock();
  }

  Future<List<Board>> getUserBoards(int id) async {
    final boards = List.filled(5, 1).map((_) => Board.fromMock()).toList();
    return Future.value(boards);
  }
}
