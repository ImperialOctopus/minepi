import 'package:mein_haus/model/output_state.dart';

abstract class DataRepository {
  Future<void> checkUser(String identifier);

  Future<Stream<OutputState>> getStateStream(String identifier);
}
