import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/model/auth.dart';
import 'package:mockito/mockito.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('AuthApi test', () {
    MockApiClient apiClient;
    DefaultAuthApi authApi;

    setUp(() {
      apiClient = MockApiClient();
      authApi = DefaultAuthApi(apiClient);
    });

    test('sign in test', () async {
      const expected = Auth(token: 'token', userId: 0);
      when(apiClient.post(any, body: anyNamed('body'))).thenAnswer((_) =>
          Future.value(ApiResponse(jsonEncode(expected.toJson()), 200)));

      final actual = await authApi.signIn(SignInRequestBody.fromMock());

      expect(actual, equals(expected));
    });

    test('sign up test', () async {
      const expected = Auth(token: 'token', userId: 0);
      when(apiClient.post(any, body: anyNamed('body'))).thenAnswer((_) =>
          Future.value(ApiResponse(jsonEncode(expected.toJson()), 200)));

      final actual = await authApi.signUp(SignUpRequestBody.fromMock());

      expect(actual, equals(expected));
    });
  });
}
