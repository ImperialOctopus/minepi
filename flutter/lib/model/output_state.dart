import 'package:equatable/equatable.dart';

/// Map of data for monitor.
class OutputState extends Equatable {
  final Map<String, int> data;

  const OutputState({required this.data});

  @override
  List<Object?> get props => [data];
}
