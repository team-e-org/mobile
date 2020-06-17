import 'package:mobile/api/boards_api.dart';
import 'package:mobile/model/models.dart';

abstract class BoardsRepository {
  Future<List<Pin>> getBoardPins({int id, int page}) async {}
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
}

class MockBoardsRepository extends BoardsRepository {
  factory MockBoardsRepository() {
    return _instance ?? MockBoardsRepository._internal();
  }

  MockBoardsRepository._internal();

  static MockBoardsRepository _instance;

  Future<List<Pin>> getBoardPins({int id, int page}) async {
    final pins = List.filled(10, 1).map((_) => Pin.fromMock()).toList();
    return Future.value(pins);
  }
}
