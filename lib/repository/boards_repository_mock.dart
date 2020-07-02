import 'package:mobile/model/models.dart';
import 'package:mobile/repository/boards_repository.dart';

class MockBoardsRepository extends BoardsRepository {
  factory MockBoardsRepository() {
    return _instance ?? MockBoardsRepository._internal();
  }

  MockBoardsRepository._internal();

  static MockBoardsRepository _instance;

  @override
  Future<List<Pin>> getBoardPins({int id, int page}) async {
    final pins = List.filled(10, 1).map((_) => Pin.fromMock()).toList();
    return Future.value(pins);
  }

  @override
  Future<Board> createBoard(NewBoard board) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return Board(
      name: board.name,
      description: board.description,
      isPrivate: board.isPrivate,
    );
  }

  Future<Board> editBoard(int id, EditBoard editBoard) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return Board(
      name: editBoard.name,
      description: editBoard.description,
      isPrivate: editBoard.isPrivate,
    );
  }
}
