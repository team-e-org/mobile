import 'dart:io';

import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/util/image_validator.dart';

class TestCase {
  TestCase(
    this.description,
    this.image,
    this.expect,
  );

  final String description;
  final File image;
  final bool expect;
}

void main() {
  group('ImageValidatorTest', () {
    ImageValidator validator;
    setUp(() {
      validator = ImageValidator(
        maxSizeInBytes: 10 * 1024 * 1024,
        acceptedMimeTypes: [
          'image/jpeg',
          'image/jpg',
          'image/png',
          'image/heic',
        ],
      );
    });

    test('validate test', () async {
      final cases = <TestCase>[
        TestCase(
          'file size limit',
          MemoryFileSystem().file('image.jpg')
            ..writeAsBytesSync(List.filled(10 * 1024 * 1024, 0)),
          true,
        ),
        TestCase(
          'file size over than limit',
          MemoryFileSystem().file('image.jpg')
            ..writeAsBytesSync(List.filled(10 * 1024 * 1024 + 1, 0)),
          false,
        ),
        TestCase(
          'jpg file',
          File('test/assets/cake.jpg'),
          true,
        ),
        TestCase(
          'png file',
          File('test/assets/cake.png'),
          true,
        ),
        TestCase(
          'heic file',
          File('test/assets/cake.heic'),
          true,
        ),
        TestCase(
          'unsupported file',
          File('test/assets/cake.pdf'),
          false,
        ),
      ];

      for (final c in cases) {
        final actual = await validator.validate(c.image);
        expect(actual, equals(c.expect),
            reason: 'Failing case: ${c.description}');
      }
    });
  });
}
