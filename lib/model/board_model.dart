import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NewBoard {
  NewBoard({
    @required this.name,
    this.description,
    @required this.isPrivate,
  });

  String name;
  String description;
  bool isPrivate;

  factory NewBoard.fromJson(Map<String, dynamic> json) =>
      _$NewBoardFromJson(json);

  Map<String, dynamic> toJson() => _$NewBoardToJson(this);
}

@JsonSerializable(includeIfNull: false)
class EditBoard {
  EditBoard({
    this.name,
    this.description,
    this.isPrivate,
    this.isArchive,
  });

  String name;
  String description;
  bool isPrivate;
  bool isArchive;

  factory EditBoard.fromJson(Map<String, dynamic> json) =>
      _$EditBoardFromJson(json);

  Map<String, dynamic> toJson() => _$EditBoardToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Board extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String description;
  final bool isPrivate;
  final bool isArchive;

  Board({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.isPrivate,
    this.isArchive,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);

  static Board fromMock() {
    return Board(
      id: 1234,
      userId: 143,
      name: "board name",
      description: "description",
      isPrivate: false,
      isArchive: false,
    );
  }

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
