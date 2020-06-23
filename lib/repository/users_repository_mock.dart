import 'package:mobile/model/models.dart';
import 'package:mobile/repository/users_repository.dart';

class MockUsersRepository extends UsersRepository {
  factory MockUsersRepository() {
    return _instance ?? MockUsersRepository._internal();
  }

  MockUsersRepository._internal();

  static MockUsersRepository _instance;

  @override
  Future<User> getUser(int id) => Future.value(User.fromMock());

  @override
  Future<List<Board>> getUserBoards(int id) async {
    final boards = List.filled(5, 1).map((_) => Board.fromMock()).toList();
    return Future.value(boards);
  }
}
