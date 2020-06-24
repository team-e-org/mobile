import 'package:mobile/model/pin_model.dart';
import 'package:mobile/repository/pins_repository.dart';

class MockPinsRepository extends PinsRepository {
  factory MockPinsRepository() {
    return _instance ?? MockPinsRepository._internal();
  }

  MockPinsRepository._internal();

  static MockPinsRepository _instance;

  @override
  Future<List<Pin>> getHomePagePins({int page}) async {
    final pins = List.filled(10, 1).map((_) => Pin.fromMock()).toList();
    return Future.value(pins);
  }

  Future<List<Pin>> getBoardPins({int boardId, int page}) async {
    final pins = List.filled(10, 1).map((_) => Pin.fromMock()).toList();
    return Future.value(pins);
  }
}
