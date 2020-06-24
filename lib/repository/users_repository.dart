import 'package:mobile/api/users_api.dart';
import 'package:mobile/model/models.dart';

abstract class UsersRepository {
  Future<User> getUser(int id);

  Future<List<Board>> getUserBoards(int id);
}

class DefaultUsersRepository extends UsersRepository {
  factory DefaultUsersRepository(UsersApi api) {
    return _instance ?? DefaultUsersRepository._internal(api);
  }

  DefaultUsersRepository._internal(this._api);

  static DefaultUsersRepository _instance;
  UsersApi _api;

  @override
  Future<User> getUser(int id) => _api.user(id: id);

  @override
  Future<List<Board>> getUserBoards(int id) => _api.userBoards(id: id);
}
