import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/output_state.dart';
import 'data_repository.dart';

/// Firebase implementation of data repository.
class FirebaseDataRepository implements DataRepository {
  @override
  Future<bool> checkUser(String identifier) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(identifier)
        .get();

    return (userDoc.exists);
  }

  @override
  Future<Stream<OutputState>> getStateStream(String identifier) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(identifier)
        .snapshots()
        .map((DocumentSnapshot snapshot) => snapshot.data())
        .where((data) => data != null)
        .map((data) => OutputState(data: data!.cast<String, int>()));
  }
}
