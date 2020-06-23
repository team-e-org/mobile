import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/data/authentication_preferences.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements Client {}

class MockAuthenticationPreferences extends Mock
    implements AuthenticationPreferences {}

void main() {
  MockHttpClient mockHttpClient;
  ApiClient apiClient;
  group('ApiClient test', () {
    setUp(() {
      mockHttpClient = MockHttpClient();
      final mockAuthenticationPreferences = MockAuthenticationPreferences();
      when(mockAuthenticationPreferences.getAccessToken())
          .thenAnswer((_) => 'token');

      apiClient = ApiClient(
        mockHttpClient,
        prefs: mockAuthenticationPreferences,
        apiEndpoint: '',
      );
    });

    test('get test', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.value(Response('body', 200)));
      final response = await apiClient.get('200');
      expect(response.statusCode, equals(200));
    });

    test('post test', () async {
      when(mockHttpClient.post(any, headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.value(Response('body', 201)));
      final response = await apiClient.post('201');
      expect(response.statusCode, equals(201));
    });

    test('put test', () async {
      when(mockHttpClient.put(any, headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.value(Response('body', 200)));
      final response = await apiClient.put('200');
      expect(response.statusCode, equals(200));
    });

    test('delete test', () async {
      when(mockHttpClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((realInvocation) => Future.value(Response('body', 204)));
      final response = await apiClient.delete('204');
      expect(response.statusCode, equals(204));
    });
  });

  group('ApiClient error handling', () {
    setUp(() async {
      mockHttpClient = MockHttpClient();
      final mockAuthenticationPreferences = MockAuthenticationPreferences();
      when(mockAuthenticationPreferences.getAccessToken())
          .thenAnswer((_) => 'token');

      apiClient = ApiClient(
        mockHttpClient,
        prefs: mockAuthenticationPreferences,
        apiEndpoint: '',
      );
    });

    test(
        'when API return response with status code 401, [get] function should throw [UnauthorizedError]',
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) => Future.value(Response('body', 401)));

      final getFuture = apiClient.get('401');
      expect(getFuture, throwsA(isInstanceOf<UnauthorizedError>()));
    });

    test(
        'when API return response with status code 403, [get] function should throw [ForbiddenServerError]',
        () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) => Future.value(Response('body', 403)));

      final getFuture = apiClient.get('403');
      expect(getFuture, throwsA(isInstanceOf<ForbiddenServerError>()));
    });

    test(
        'when API return response with status code 404, [get] function should throw [NotFoundError]',
        () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) => Future.value(Response('body', 404)));

      final getFuture = apiClient.get('404');
      expect(getFuture, throwsA(isInstanceOf<NotFoundError>()));
    });

    test(
        'when API return response with status code 500, [get] function should throw [UnknownServerError]',
        () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) => Future.value(Response('body', 500)));

      final getFuture = apiClient.get('500');
      expect(getFuture, throwsA(isInstanceOf<UnknownServerError>()));
    });

    test(
        'when API return response with status code 422, [get] function should throw UnprocessableEntityError',
        () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) => Future.value(Response('body', 422)));

      final getFuture = apiClient.get('422');
      expect(getFuture, throwsA(isInstanceOf<UnprocessableEntityError>()));
    });

    test(
        'when API return response with status code 999, [get] function should throw UnknownClientError',
        () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) => Future.value(Response('body', 999)));

      final getFuture = apiClient.get('999');
      expect(getFuture, throwsA(isInstanceOf<UnknownClientError>()));
    });
  });
}
