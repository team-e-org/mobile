import 'package:mobile/bloc/pins_bloc.dart';
import 'package:mobile/model/pin_model.dart';
import 'package:mobile/repository/pins_repository.dart';

class HomeScreenBloc extends PinsBloc {
  HomeScreenBloc(this.pinsRepository);

  final PinsRepository pinsRepository;

  @override
  Future<List<Pin>> getPins({int page}) => pinsRepository.getHomePagePins();
}
