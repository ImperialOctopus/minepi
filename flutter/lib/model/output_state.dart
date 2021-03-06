import 'package:equatable/equatable.dart';

/// Map of data for monitor.
class OutputState extends Equatable {
  /// Data for this state.
  final Map<String, int> data;

  /// Map of data for monitor.
  const OutputState({required this.data});

  @override
  List<Object?> get props => [data];
}
