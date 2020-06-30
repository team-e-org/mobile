import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pin_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NewPin extends Equatable {
  const NewPin({
    @required this.title,
    this.image,
    this.description,
    this.url,
    this.isPrivate,
  });

  final String title;
  final String description;
  final String url;
  final bool isPrivate;
  final String image;

  factory NewPin.fromJson(Map<String, dynamic> json) => _$NewPinFromJson(json);

  factory NewPin.fromMock() => const NewPin(
        title: 'my pin',
        description: 'pin description',
        url: 'https://example.com',
        isPrivate: false,
      );

  Map<String, dynamic> toJson() => _$NewPinToJson(this);

  @override
  List<Object> get props => [
        title,
        image,
        description,
        url,
        isPrivate,
      ];
}

@JsonSerializable(includeIfNull: false)
class EditPin extends Equatable {
  const EditPin({
    this.title,
    this.description,
    this.isPrivate,
  });

  final String title;
  final String description;
  final bool isPrivate;

  factory EditPin.fromJson(Map<String, dynamic> json) =>
      _$EditPinFromJson(json);

  factory EditPin.fromMock() => const EditPin(
        title: 'my pin',
        description: 'pin description',
        isPrivate: false,
      );

  Map<String, dynamic> toJson() => _$EditPinToJson(this);

  @override
  List<Object> get props => [
        title,
        description,
        isPrivate,
      ];
}

@JsonSerializable(includeIfNull: false)
class Pin extends Equatable {
  const Pin({
    this.id,
    this.title,
    this.description,
    this.url,
    this.userId,
    this.imageUrl,
    this.isPrivate,
  });

  final int id;
  final String title;
  final String description;
  final String url;
  final int userId;
  final String imageUrl;
  final bool isPrivate;

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);

  factory Pin.fromMock() {
    const width = 200;
    const height = 400;

    return const Pin(
      id: 123,
      title: 'title',
      description: 'description',
      url: 'http://www.sample.com',
      userId: 143,
      imageUrl: 'https://source.unsplash.com/random/${width}x${height}',
      isPrivate: false,
    );
  }

  Map<String, dynamic> toJson() => _$PinToJson(this);

  @override
  List<Object> get props => [
        id,
        title,
        description,
        url,
        userId,
        imageUrl,
        isPrivate,
      ];
}

extension _TagsString on String {
  static String separator = ' ';

  List<String> toTagList() => split(separator);

  static String fromTagList(List<String> tagList) => tagList.join(separator);
}
