import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NewBoard extends Equatable {
  const NewBoard({
    @required this.name,
    this.description,
    @required this.isPrivate,
  });

  final String name;
  final String description;
  final bool isPrivate;

  factory NewBoard.fromJson(Map<String, dynamic> json) =>
      _$NewBoardFromJson(json);

  factory NewBoard.fromMock() => const NewBoard(
        name: 'my board',
        description: 'board description',
        isPrivate: false,
      );

  Map<String, dynamic> toJson() => _$NewBoardToJson(this);

  @override
  List<Object> get props => [
        name,
        description,
        isPrivate,
      ];
}

@JsonSerializable(includeIfNull: false)
class EditBoard extends Equatable {
  const EditBoard({
    this.name,
    this.description,
    this.isPrivate,
    this.isArchive,
  });

  final String name;
  final String description;
  final bool isPrivate;
  final bool isArchive;

  factory EditBoard.fromJson(Map<String, dynamic> json) =>
      _$EditBoardFromJson(json);

  factory EditBoard.fromMock() => const EditBoard(
        name: 'my board',
        description: 'board description',
        isPrivate: false,
        isArchive: false,
      );

  Map<String, dynamic> toJson() => _$EditBoardToJson(this);

  @override
  List<Object> get props => [
        name,
        description,
        isPrivate,
        isArchive,
      ];
}

@JsonSerializable(includeIfNull: false)
class Board extends Equatable {
  const Board({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.isPrivate,
    this.isArchive,
  });

  final int id;
  final int userId;
  final String name;
  final String description;
  final bool isPrivate;
  final bool isArchive;

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  factory Board.fromMock() => const Board(
        id: 1234,
        userId: 143,
        name: 'board name',
        description: 'description',
        isPrivate: false,
        isArchive: false,
      );

  Map<String, dynamic> toJson() => _$BoardToJson(this);

  @override
  List<Object> get props => [
        id,
        userId,
        name,
        description,
        isPrivate,
        isArchive,
      ];
}
