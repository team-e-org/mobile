class PinsRepository {
  factory PinsRepository() {
    return _instance ?? PinsRepository._internal();
  }

  PinsRepository._internal();

  static PinsRepository _instance;
}
