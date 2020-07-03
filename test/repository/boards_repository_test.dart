import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/api/boards_api.dart';
import 'package:mobile/api/pins_api.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/boards_repository.dart';
import 'package:mockito/mockito.dart';

class MockBoardsApi extends Mock implements BoardsApi {}

class MockPinsApi extends Mock implements PinsApi {}

void main() {
  MockBoardsApi boardsApi;
  MockPinsApi pinsApi;
  DefaultBoardsRepository repo;

  group('boards repository test', () {
    setUp(() {
      boardsApi = MockBoardsApi();
      pinsApi = MockPinsApi();
      repo = DefaultBoardsRepository(
        boardsApi: boardsApi,
        pinsApi: pinsApi,
      );
    });

    test('get board pins', () async {
      when(boardsApi.boardPins(id: anyNamed('id'), page: anyNamed('page')))
          .thenAnswer((_) => Future.value([Pin.fromMock()]));

      when(pinsApi.getTags(pinId: anyNamed('pinId')))
          .thenAnswer((_) => Future.value(['dog', 'cat']));

      final actual = await repo.getBoardPins(id: 1, page: 1);
      final expected = Pin.fromMock()..tags = ['dog', 'cat'];

      expect(actual, equals([expected]));
    });

    test('create board', () async {
      when(boardsApi.newBoard(board: anyNamed('board')))
          .thenAnswer((_) => Future.value(Board.fromMock()));

      final actual = await repo.createBoard(NewBoard.fromMock());

      expect(actual, equals(Board.fromMock()));
    });

    test('edit board', () async {
      when(boardsApi.editBoard(id: anyNamed('id'), board: anyNamed('board')))
          .thenAnswer((_) => Future.value(Board.fromMock()));

      final actual = await repo.editBoard(1, EditBoard.fromMock());

      expect(actual, equals(Board.fromMock()));
    });
  });
}
