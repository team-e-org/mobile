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
  factory DefaultPinsRepository({PinsApi pinsApi, BoardsApi boardsApi}) {
    return _instance ?? DefaultPinsRepository._internal(pinsApi, boardsApi);
  }

  DefaultPinsRepository._internal(this._pinsApi, this._boardsApi);

  static DefaultPinsRepository _instance;
  PinsApi _pinsApi;
  BoardsApi _boardsApi;

  @override
  Future<List<Pin>> getHomePagePins({int page}) =>
      _pinsApi.pins(page: page ?? 1);
  Future<List<Pin>> getBoardPins({int boardId, int page}) =>
      _boardsApi.boardPins(id: boardId, page: page ?? 1);

  @override
  Future<void> createPin(NewPin newPin, File imageFile, Board board) async {
    try {
      await _pinsApi.newPin(
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
