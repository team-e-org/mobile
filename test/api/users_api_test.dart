import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/users_api.dart';
import 'package:mobile/model/board_model.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mockito/mockito.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('Users api test', () {
    MockApiClient apiClient;
    DefaultUsersApi usersApi;

    setUp(() {
      apiClient = MockApiClient();
      usersApi = DefaultUsersApi(apiClient);
    });

    test('get user test', () async {
      final expected = User.fromMock();
      when(apiClient.get(any)).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await usersApi.user(id: 0);

      expect(actual, equals(expected));
    });

    test('edit user test', () async {
      final expected = User.fromMock();
      when(apiClient.put(any, body: anyNamed('body'))).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await usersApi.editUser(id: 0, user: EditUser.fromMock());

      expect(actual, equals(expected));
    });

    test('delete user test', () async {
      when(apiClient.delete(any))
          .thenAnswer((_) => Future.value(ApiResponse('', 204)));

      final actual = await usersApi.deleteUser(id: 0);

      expect(actual, equals(true));
    });

    test('get user boards test', () async {
      final expected = List.filled(10, Board.fromMock());
      when(apiClient.get(any)).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await usersApi.userBoards(id: 0);

      expect(actual, equals(expected));
    });

    test('get user pins test', () async {
      final expected = List.filled(10, Pin.fromMock());
      when(apiClient.get(any)).thenAnswer(
          (_) => Future.value(ApiResponse(jsonEncode(expected), 200)));

      final actual = await usersApi.userPins(id: 0);

      expect(actual, equals(expected));
    });
  });
}
