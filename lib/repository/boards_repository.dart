import 'package:mobile/api/boards_api.dart';
import 'package:mobile/model/models.dart';

abstract class BoardsRepository {
  Future<List<Pin>> getBoardPins({int id, int page});

  Future<Board> createBoard(NewBoard board);

  Future<Board> editBoard(int id, EditBoard editBoard);
}

class DefaultBoardsRepository extends BoardsRepository {
  DefaultBoardsRepository(this.api);

  BoardsApi api;

  Future<List<Pin>> getBoardPins({int id, int page}) =>
      api.boardPins(id: id, page: page);

  Future<Board> createBoard(NewBoard board) => api.newBoard(board: board);

  Future<Board> editBoard(int id, EditBoard editBoard) =>
      api.editBoard(id: id, board: editBoard);
}
