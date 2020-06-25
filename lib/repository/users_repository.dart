import 'package:mobile/api/users_api.dart';
import 'package:mobile/model/models.dart';

abstract class UsersRepository {
  Future<User> getUser(int id);

  Future<List<Board>> getUserBoards(int id);
}

class DefaultUsersRepository extends UsersRepository {
  DefaultUsersRepository(this.api);

  UsersApi api;

  @override
  Future<User> getUser(int id) => api.user(id: id);

  @override
  Future<List<Board>> getUserBoards(int id) => api.userBoards(id: id);
}
