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
      final expected = Auth(token: 'token', userId: 0);

      when(apiClient.post(any, body: anyNamed('body'))).thenAnswer(
          (_) =>
              Future.value(Response(jsonEncode(expected.toJson()), 123)));

      final actual = await authApi.signIn(SignInRequestBody(
        email: 'abc@example.com',
        password: 'password',
      ));

      print(actual);
      expect(actual, equals(expected));
    });
  });
}
