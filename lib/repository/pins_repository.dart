import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/models.dart';

abstract class PinsRepository {
  Future<List<Pin>> getHomePagePins({int page});
}

class DefaultPinsRepository extends PinsRepository {
  factory DefaultPinsRepository(PinsApi api) {
    return _instance ?? DefaultPinsRepository._internal(api);
  }

  DefaultPinsRepository._internal(this._api);

  static DefaultPinsRepository _instance;
  PinsApi _api;

  Future<List<Pin>> getHomePagePins({int page}) async {
    return _api.pins(page: page ?? 1);
  }
}

class MockPinsRepository extends PinsRepository {
  factory MockPinsRepository() {
    return _instance ?? MockPinsRepository._internal();
  }

  MockPinsRepository._internal();

  static MockPinsRepository _instance;

  Future<List<Pin>> getHomePagePins({int page}) async {
    final pins = List.filled(10, 1).map((_) => Pin.fromMock()).toList();
    return Future.value(pins);
  }
}
