abstract class PinsApi{
  Future<List<PinModel>> pins();
  Future<PinModel> pin(String id);
  Future<bool> editPin(Pin pin);
  Future<bool> deletePin(Pin pin);
}
