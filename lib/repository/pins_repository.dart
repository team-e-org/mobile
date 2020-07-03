import 'package:mobile/api/boards_api.dart';
import 'dart:io';

import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/models.dart';

abstract class PinsRepository {
  Future<RecommendPinResponse> getReccomendPins({String pagingKey});
  Future<List<Pin>> getBoardPins({int boardId, int page});
  Future<List<Pin>> getPinsByTag({String tag, int page});
  Future<void> createPin(NewPin newPin, File imageFile, Board board);
  Future<void> editPin(int pinId, EditPin editPin);
  Future<void> removePin(int boardId, int pinId);
  Future<bool> savePin({int pinId, int boardId});
}

class DefaultPinsRepository extends PinsRepository {
  DefaultPinsRepository({
    this.pinsApi,
    this.boardsApi,
  });

  PinsApi pinsApi;
  BoardsApi boardsApi;

  @override
  Future<RecommendPinResponse> getReccomendPins({String pagingKey}) async {
    final res = await pinsApi.getRecommendPins(pagingKey: pagingKey);
    for (var i = 0; i < res.pins.length; i++) {
      res.pins[i].tags = await pinsApi.getTags(pinId: res.pins[i].id);
    }
    return res;
  }

  Future<List<Pin>> getPinsByTag({String tag, int page}) async {}

  Future<List<Pin>> getBoardPins({int boardId, int page}) async {
    final pins = await boardsApi.boardPins(id: boardId, page: page ?? 1);
    for (var i = 0; i < pins.length; i++) {
      pins[i].tags = await pinsApi.getTags(pinId: pins[i].id);
    }
    return pins;
  }

  @override
  Future<void> createPin(NewPin newPin, File imageFile, Board board) async {
    try {
      await pinsApi.newPin(
        title: newPin.title,
        description: newPin.description,
        url: newPin.url,
        isPrivate: newPin.isPrivate,
        tagsString: newPin.tagsString,
        imageBytes: imageFile.readAsBytesSync(),
        boardId: board.id,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> editPin(int pinId, EditPin editPin) async {
    try {
      await pinsApi.editPin(id: pinId, pin: editPin);
    } on Exception {
      rethrow;
    }
  }

  Future<bool> removePin(int boardId, int pinId) async {
    return pinsApi.unsavePin(boardId: boardId, pinId: pinId);
  }

  Future<bool> savePin({int pinId, int boardId}) async {
    return pinsApi.savePin(pinId: pinId, boardId: boardId);
  }
}
