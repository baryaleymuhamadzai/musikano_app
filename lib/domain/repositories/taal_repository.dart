import '../models/taal.dart';

abstract class TaalRepository {
  List<Taal> getAllTaals();
  Taal getTaalById(String id);
}
