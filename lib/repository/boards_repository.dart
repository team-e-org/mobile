import 'package:mobile/api/boards_api.dart';
import 'package:mobile/model/models.dart';

class BoardsRepository {
  factory BoardsRepository(BoardsApi api) {
    return _instance ?? BoardsRepository._internal(api);
  }

  BoardsRepository._internal(this._api);

  static BoardsRepository _instance;
  BoardsApi _api;

  Future<List<Pin>> getBoardPins({int id, int page}) async {
    return _api.boardPins(id: id, page: page);
  }
}
