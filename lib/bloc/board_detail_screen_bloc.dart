import 'package:mobile/bloc/pins_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

class BoardDetailScreenBloc extends PinsBloc {
  BoardDetailScreenBloc(
    this.pinsRepository,
    this.board,
  );

  final PinsRepository pinsRepository;
  final Board board;

  @override
  Future<List<Pin>> getPins({int page}) => pinsRepository.getBoardPins(
        boardId: board.id,
        page: page,
      );
}
