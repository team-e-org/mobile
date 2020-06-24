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

  @override
  Future<List<Pin>> getHomePagePins({int page}) => _api.pins(page: page ?? 1);
}
