import 'dart:io';

import 'package:logger/logger.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/repository/pins_repository.dart';

class MockPinsRepository extends PinsRepository {
  factory MockPinsRepository() {
    return _instance ?? MockPinsRepository._internal();
  }

  MockPinsRepository._internal();

  static MockPinsRepository _instance;

  @override
  Future<RecommendPinResponse> getReccomendPins({String pagingKey}) async {
    final pins = List.filled(10, 1).map((_) => Pin.fromMock()).toList();
    return Future.value(
        RecommendPinResponse(pins: pins, pagingKey: 'pagingKey'));
  }

  Future<List<Pin>> getBoardPins({int boardId, int page}) async {
    final pins = List.filled(10, 1).map((_) => Pin.fromMock()).toList();
    return Future.value(pins);
  }

  @override
  Future<void> createPin(NewPin newPin, File imageFile, Board board) async {
    Logger()
      ..d('title: ${newPin.title}')
      ..d('description: ${newPin.description}')
      ..d('url: ${newPin.url}')
      ..d('isPrivate: ${newPin.isPrivate}')
      ..d('image is ${newPin.image.isNotEmpty ? 'exist' : 'empty'}')
      ..d('board id: ${board.id}');
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  Future<void> editPin(int pinId, EditPin editPin) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  Future<void> removePin(int boardId, int pinId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  Future<bool> savePin({int pinId, int boardId}) async {
    return Future<bool>.delayed(const Duration(seconds: 1));
  }
}
