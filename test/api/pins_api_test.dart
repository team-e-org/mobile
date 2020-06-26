import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mockito/mockito.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('PinsApi test', () {
    MockApiClient apiClient;
    DefaultPinsApi pinsApi;

    setUp(() {
      apiClient = MockApiClient();
      pinsApi = DefaultPinsApi(apiClient);
    });

    test('get pins test', () async {
      final expected = List.filled(10, Pin.fromMock());
      when(apiClient.get(any)).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await pinsApi.pins();

      expect(actual, equals(expected));
    });

    test('get a pin test', () async {
      final expected = Pin.fromMock();
      when(apiClient.get(any)).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await pinsApi.pin();

      expect(actual, equals(expected));
    });

    test('edit pin test', () async {
      final expected = Pin.fromMock();
      when(apiClient.put(any, body: anyNamed('body'))).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await pinsApi.editPin(id: 0, pin: EditPin.fromMock());

      expect(actual, equals(expected));
    });

    test('delete pin test', () async {
      when(apiClient.delete(any))
          .thenAnswer((_) => Future.value(ApiResponse('', 204)));

      final actual = await pinsApi.deletePin(id: 0);

      expect(actual, equals(true));
    });

    // TODO: newPinのテストを書く
  });
}
