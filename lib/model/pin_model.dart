import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pin_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NewPin {
  NewPin({
    @required this.title,
    this.image,
    this.description,
    this.url,
    this.isPrivate,
    this.imageFile,
  });

  final String title;
  final String description;
  final String url;
  final bool isPrivate;
  final String image;
  final File imageFile;

  factory NewPin.fromJson(Map<String, dynamic> json) => _$NewPinFromJson(json);

  Map<String, dynamic> toJson() => _$NewPinToJson(this);
}

@JsonSerializable(includeIfNull: false)
class EditPin {
  EditPin({
    this.title,
    this.description,
    this.isPrivate,
  });

  final String title;
  final String description;
  final bool isPrivate;

  factory EditPin.fromJson(Map<String, dynamic> json) =>
      _$EditPinFromJson(json);

  Map<String, dynamic> toJson() => _$EditPinToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Pin {
  final int id;
  final String title;
  final String description;
  final String url;
  final int userId;
  final String imageUrl;
  final bool isPrivate;

  Pin({
    this.id,
    this.title,
    this.description,
    this.url,
    this.userId,
    this.imageUrl,
    this.isPrivate,
  });

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);

  Map<String, dynamic> toJson() => _$PinToJson(this);

  static Pin fromMock() {
    final random = Random();
    final base = 200;
    final width = base;
    final height = random.nextInt(2 * base) + base;

    return Pin(
      id: 123,
      title: "title",
      description: "description",
      url: "http://www.sample.com",
      userId: 143,
      imageUrl: 'https://source.unsplash.com/random/${width}x${height}',
      isPrivate: false,
    );
  }
}
