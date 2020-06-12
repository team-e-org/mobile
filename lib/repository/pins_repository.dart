import 'package:mobile/api/pins_api.dart';

class PinsRepository {
  factory PinsRepository(PinsApi api) {
    return _instance ?? PinsRepository._internal(api);
  }

  PinsRepository._internal(this._api);

  static PinsRepository _instance;
  PinsApi _api;
}
