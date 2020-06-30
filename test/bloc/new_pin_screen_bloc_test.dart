import 'package:bloc_test/bloc_test.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/api/errors/error.dart';
import 'package:mobile/bloc/new_pin_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/pins_repository.dart';
import 'package:mockito/mockito.dart';

class MockPinsRepository extends Mock implements PinsRepository {}

final mockFile = MemoryFileSystem().file('image.dart')..writeAsBytesSync([0]);

void main() {
  group('new pin screen bloc test', () {
    MockPinsRepository pinsRepository;
    NewPinScreenBloc bloc;

    setUp(() {
      pinsRepository = MockPinsRepository();
      bloc = NewPinScreenBloc(
        pinsRepository: pinsRepository,
      );
    });

    test('initial state is InitialState', () {
      expect(bloc.initialState, isA<InitialState>());
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<NewPinScreenBloc, NewPinScreenEvent, NewPinScreenState>(
      'when image is not selected, should be unaccepted state',
      build: () async => bloc,
      act: (bloc) async {
        bloc.add(const ImageSelected(image: null));
      },
      expect: <dynamic>[
        ImageUnaccepted(),
      ],
    );

    blocTest<NewPinScreenBloc, NewPinScreenEvent, NewPinScreenState>(
      'when image is selected, should be accepted state',
      build: () async => bloc,
      act: (bloc) async {
        bloc.add(ImageSelected(image: PickedFile('test/assets/cake.jpg')));
      },
      expect: <dynamic>[
        ImageAccepted(
          image: MemoryFileSystem().file('test/assets/cake.jpg'),
        ),
      ],
    );

    blocTest<NewPinScreenBloc, NewPinScreenEvent, NewPinScreenState>(
      'when creating new pin succeeded, should be success state',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.createPin(any, any, any))
            .thenAnswer((_) => Future.value());
        bloc.add(SendRequest(
          newPin: NewPin.fromMock(),
          imageFile: mockFile,
          board: Board.fromMock(),
        ));
      },
      expect: <dynamic>[
        isA<Sending>(),
        isA<Finished>(),
      ],
    );

    blocTest<NewPinScreenBloc, NewPinScreenEvent, NewPinScreenState>(
      'when creating new pin failed, should be error state and it is retryable',
      build: () async => bloc,
      act: (bloc) async {
        when(pinsRepository.createPin(null, null, null))
            .thenThrow(NetworkError());
        when(pinsRepository.createPin(NewPin.fromMock(), any, Board.fromMock()))
            .thenAnswer((_) => Future.value());
        bloc
          ..add(const SendRequest(
            newPin: null,
            imageFile: null,
            board: null,
          ))
          ..add(SendRequest(
            newPin: NewPin.fromMock(),
            imageFile: mockFile,
            board: Board.fromMock(),
          ));
      },
      expect: <dynamic>[
        isA<Sending>(),
        isA<ErrorState>(),
        isA<Sending>(),
        isA<Finished>(),
      ],
    );
  });
}
