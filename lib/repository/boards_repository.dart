import 'package:mobile/api/boards_api.dart';
import 'package:mobile/model/models.dart';

abstract class BoardsRepository {
  Future<List<Pin>> getBoardPins({int id, int page});

  Future<Board> createBoard(NewBoard board);
}

class DefaultBoardsRepository {
  factory DefaultBoardsRepository(BoardsApi api) {
    return _instance ?? DefaultBoardsRepository._internal(api);
  }

  DefaultBoardsRepository._internal(this._api);

  static DefaultBoardsRepository _instance;
  BoardsApi _api;

  Future<List<Pin>> getBoardPins({int id, int page}) async {
    return _api.boardPins(id: id, page: page);
  }

  Future<Board> createBoard(NewBoard board) => _api.newBoard(board: board);
}

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
}
