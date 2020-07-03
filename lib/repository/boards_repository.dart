import 'package:flutter/widgets.dart';
import 'package:mobile/api/boards_api.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/models.dart';

abstract class BoardsRepository {
  Future<List<Pin>> getBoardPins({int id, int page});

  Future<Board> createBoard(NewBoard board);

  Future<Board> editBoard(int id, EditBoard editBoard);
}

class DefaultBoardsRepository extends BoardsRepository {
  DefaultBoardsRepository({
    @required this.boardsApi,
    @required this.pinsApi,
  });

  BoardsApi boardsApi;
  PinsApi pinsApi;

  Future<List<Pin>> getBoardPins({int id, int page}) async {
    final pins = await boardsApi.boardPins(id: id, page: page ?? 1);
    for (var i = 0; i < pins.length; i++) {
      pins[i].tags = await pinsApi.getTags(pinId: pins[i].id);
    }
    return pins;
  }

  Future<Board> createBoard(NewBoard board) => boardsApi.newBoard(board: board);

  Future<Board> editBoard(int id, EditBoard editBoard) =>
      boardsApi.editBoard(id: id, board: editBoard);
}
