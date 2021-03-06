import '../../model/output_state.dart';

/// Repository for app data.
abstract class DataRepository {
  /// Checks the user exists.
  Future<bool> checkUser(String identifier);

  /// Gets a stream of output states.
  Future<Stream<OutputState>> getStateStream(String identifier);
}
