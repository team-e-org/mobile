import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/boards_api.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mockito/mockito.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('AuthApi test', () {
    MockApiClient apiClient;
    DefaultBoardsApi boardsApi;

    setUp(() {
      apiClient = MockApiClient();
      boardsApi = DefaultBoardsApi(apiClient);
    });

    test('new board test', () async {
      final expected = Board.fromMock();
      when(apiClient.post(any, body: anyNamed('body'))).thenAnswer((_) =>
          Future.value(ApiResponse(jsonEncode(expected.toJson()), 200)));

      final actual = await boardsApi.newBoard(board: NewBoard.fromMock());

      expect(actual, equals(expected));
    });

    test('delete board test', () async {
      when(apiClient.delete(any))
          .thenAnswer((_) => Future.value(ApiResponse('', 204)));

      final success = await boardsApi.deleteBoard(id: 1);
      expect(success, equals(true));
    });

    test('edit board test', () async {
      final expected = Board.fromMock();
      when(apiClient.put(any, body: anyNamed('body'))).thenAnswer((_) =>
          Future.value(ApiResponse(jsonEncode(expected.toJson()), 200)));

      final actual = await boardsApi.editBoard(
        id: 1,
        board: EditBoard.fromMock(),
      );

      expect(actual, equals(expected));
    });

    test('board pins test', () async {
      final expected = List.filled(10, Pin.fromMock());
      when(apiClient.get(any)).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await boardsApi.boardPins(id: 1);

      expect(actual, equals(expected));
    });
  });
}
