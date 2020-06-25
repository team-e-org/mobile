import 'package:mobile/api/boards_api.dart';
import 'dart:io';

import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/models.dart';

abstract class PinsRepository {
  Future<List<Pin>> getHomePagePins({int page});
  Future<List<Pin>> getBoardPins({int boardId, int page});
  Future<void> createPin(NewPin newPin, File imageFile, Board board);
}

class DefaultPinsRepository extends PinsRepository {
  DefaultPinsRepository({
    this.pinsApi,
    this.boardsApi,
  });

  PinsApi pinsApi;
  BoardsApi boardsApi;

  @override
  Future<List<Pin>> getHomePagePins({int page}) =>
      pinsApi.pins(page: page ?? 1);
  Future<List<Pin>> getBoardPins({int boardId, int page}) =>
      boardsApi.boardPins(id: boardId, page: page ?? 1);

  @override
  Future<void> createPin(NewPin newPin, File imageFile, Board board) async {
    try {
      await pinsApi.newPin(
        title: newPin.title,
        description: newPin.description,
        url: newPin.url,
        isPrivate: newPin.isPrivate,
        imageBytes: imageFile.readAsBytesSync(),
        boardId: board.id,
      );
    } on Exception {
      rethrow;
    }
  }
}
