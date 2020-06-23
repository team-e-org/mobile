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

  Future<List<Pin>> getBoardPins({int id, int page}) =>
      _api.boardPins(id: id, page: page);

  Future<Board> createBoard(NewBoard board) => _api.newBoard(board: board);
}
