/// Maps a map into an iterable.
extension MapToIterable<K, V> on Map<K, V> {
  /// Maps a map into an iterable.
  Iterable<T> mapToIterable<T>(T Function(K, V) f) {
    return entries.map((e) => f(e.key, e.value));
  }
}
