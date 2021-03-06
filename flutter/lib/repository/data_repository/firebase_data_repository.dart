import '../../model/output_state.dart';
import 'data_repository.dart';

/// Firebase implementation of data repository.
class FirebaseDataRepository implements DataRepository {
  @override
  Future<bool> checkUser(String identifier) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<Stream<OutputState>> getStateStream(String identifier) async {}
}
