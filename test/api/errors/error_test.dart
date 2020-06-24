import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/errors/error.dart';

void main() {
  group('http error test', () {
    test('network error', () {
      expect(NetworkError().getMessage().isNotEmpty, equals(true));
    });

    test('forbidden server error', () {
      expect(ForbiddenServerError().getMessage().isNotEmpty, equals(true));
    });

    test('not found error', () {
      expect(NotFoundError('https://example.com').getMessage().isNotEmpty,
          equals(true));
    });

    test('unauthorized error', () {
      expect(UnauthorizedError().getMessage().isNotEmpty, equals(true));
    });

    test('unprocessable entity error', () {
      expect(UnprocessableEntityError().getMessage().isNotEmpty, equals(true));
    });

    test('unknown client error', () {
      expect(
          UnknownClientError(Exception('unknown client error'))
              .getMessage()
              .isNotEmpty,
          equals(true));
    });

    test('unknwon server error error', () {
      expect(
          UnknownServerError(Exception('unknown server error'), 999)
              .getMessage()
              .isNotEmpty,
          equals(true));
    });
  });
}
