import '../../model/output_state.dart';
import 'data_repository.dart';

class FirebaseDataRepository implements DataRepository {
  @override
  Future<void> checkUser(String identifier) async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Stream<OutputState>> getStateStream(String identifier) {
    // TODO: implement getStateStream
    throw UnimplementedError();
  }
}
