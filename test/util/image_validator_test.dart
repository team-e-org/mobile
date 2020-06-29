import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
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
      validator = ImageValidator(maxSizeInBytes: 1000);
    });

    test('validate test', () async {
      final cases = <TestCase>[
        TestCase(
            'file size limit',
            MemoryFileSystem().file('image.dart')
              ..writeAsBytesSync(List.filled(1000, 0)),
            true),
        TestCase(
            'file size over than limit',
            MemoryFileSystem().file('image.dart')
              ..writeAsBytesSync(List.filled(1001, 0)),
            false),
      ];

      for (final c in cases) {
        final actual = await validator.validate(c.image);
        expect(actual, equals(c.expect));
      }
    });
  });
}
