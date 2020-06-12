import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/models.dart';

class PinsRepository {
  factory PinsRepository(PinsApi api) {
    return _instance ?? PinsRepository._internal(api);
  }

  PinsRepository._internal(this._api);

  static PinsRepository _instance;
  PinsApi _api;

  Future<List<Pin>> getHomePagePins({int page}) async {
    return _api.pins(page: page ?? 1);
  }
}
