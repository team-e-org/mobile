import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pin_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NewPin extends Equatable {
  NewPin({
    @required this.title,
    this.image,
    this.description,
    this.url,
    this.isPrivate,
    List<String> tags,
  }) {
    tagsString = _TagsString.fromTagList(tags);
  }

  final String title;
  final String description;
  final String url;
  final bool isPrivate;
  final String image;

  String tagsString;
  List<String> get tags => tagsString.toTagList();
  set tags(List<String> tags) {
    tagsString = _TagsString.fromTagList(tags);
  }

  factory NewPin.fromJson(Map<String, dynamic> json) => NewPin(
        title: json['title'] as String,
        image: json['image'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        isPrivate: json['isPrivate'] as bool,
        tags: (json['tags'] as String)?.toTagList(),
      );

  factory NewPin.fromMock() => NewPin(
        title: 'my pin',
        description: 'pin description',
        url: 'https://example.com',
        isPrivate: false,
        tags: [],
      );

  Map<String, dynamic> toJson() {
    {
      final instance = this;
      final val = <String, dynamic>{};

      void writeNotNull(String key, dynamic value) {
        if (value != null) {
          val[key] = value;
        }
      }

      writeNotNull('title', instance.title);
      writeNotNull('description', instance.description);
      writeNotNull('url', instance.url);
      writeNotNull('isPrivate', instance.isPrivate);
      writeNotNull('image', instance.image);
      writeNotNull('tagsString', instance.tagsString);
      return val;
    }
  }

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
  EditPin({
    this.title,
    this.description,
    this.isPrivate,
    List<String> tags,
  }) {
    tagsString = _TagsString.fromTagList(tags);
  }

  final String title;
  final String description;
  final bool isPrivate;

  String tagsString;
  List<String> get tags => tagsString.toTagList();
  set tags(List<String> tags) {
    tagsString = _TagsString.fromTagList(tags);
  }

  factory EditPin.fromJson(Map<String, dynamic> json) => EditPin(
        title: json['title'] as String,
        description: json['description'] as String,
        isPrivate: json['isPrivate'] as bool,
        tags: (json['tags'] as String)?.toTagList(),
      );

  factory EditPin.fromMock() => EditPin(
        title: 'my pin',
        description: 'pin description',
        isPrivate: false,
        tags: [],
      );

  Map<String, dynamic> toJson() {
    {
      final instance = this;
      final val = <String, dynamic>{};

      void writeNotNull(String key, dynamic value) {
        if (value != null) {
          val[key] = value;
        }
      }

      writeNotNull('title', instance.title);
      writeNotNull('description', instance.description);
      writeNotNull('isPrivate', instance.isPrivate);
      writeNotNull('tagsString', instance.tagsString);
      writeNotNull('tags', instance.tags);
      return val;
    }
  }

  @override
  List<Object> get props => [
        title,
        description,
        isPrivate,
      ];
}

@JsonSerializable(includeIfNull: false)
class Pin extends Equatable {
  Pin({
    this.id,
    this.title,
    this.description,
    this.url,
    this.userId,
    this.imageUrl,
    this.isPrivate,
    List<String> tags,
  }) {
    tagsString = _TagsString.fromTagList(tags);
  }

  final int id;
  final String title;
  final String description;
  final String url;
  final int userId;
  final String imageUrl;
  final bool isPrivate;

  String tagsString;
  List<String> get tags => tagsString.toTagList();
  set tags(List<String> tags) {
    tagsString = _TagsString.fromTagList(tags);
  }

  factory Pin.fromJson(Map<String, dynamic> json) => Pin(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        userId: json['userId'] as int,
        imageUrl: json['imageUrl'] as String,
        isPrivate: json['isPrivate'] as bool,
        tags: (json['tags'] as String)?.toTagList(),
      );

  factory Pin.fromMock() {
    const width = 200;
    const height = 400;

    return Pin(
      id: 123,
      title: 'title',
      description: 'description',
      url: 'http://www.sample.com',
      userId: 143,
      imageUrl: 'https://source.unsplash.com/random/${width}x${height}',
      isPrivate: false,
      tags: [],
    );
  }

  Map<String, dynamic> toJson() {
    final instance = this;
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('id', instance.id);
    writeNotNull('title', instance.title);
    writeNotNull('description', instance.description);
    writeNotNull('url', instance.url);
    writeNotNull('userId', instance.userId);
    writeNotNull('imageUrl', instance.imageUrl);
    writeNotNull('isPrivate', instance.isPrivate);
    writeNotNull('tagsString', instance.tagsString);
    writeNotNull('tags', instance.tags);
    return val;
  }

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
