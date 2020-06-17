import 'package:mobile/api/users_api.dart';
import 'package:mobile/model/models.dart';

class UsersRepository {
  factory UsersRepository(UsersApi api) {
    return _instance ?? UsersRepository._internal(api);
  }

  UsersRepository._internal(this._api);

  static UsersRepository _instance;
  UsersApi _api;

  Future<User> getUser(int id) async {
    return User.fromMock();
  }

  Future<List<Board>> getUserBoards(int id) async {
    // return _api.userBoards(id);
    return _api.userBoards(id: 111);
  }
}
