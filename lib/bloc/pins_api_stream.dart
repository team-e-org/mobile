import 'package:mobile/model/models.dart';
import 'package:mobile/repository/repositories.dart';

class PinsApiStreams {
  PinsRepository repository;
  PinsApiStreams(this.repository);

  Stream<List<Pin>> getHomePagePins({int page}) {
    return Stream.fromFuture(repository.getHomePagePins(page: page ?? 1));
  }
}
