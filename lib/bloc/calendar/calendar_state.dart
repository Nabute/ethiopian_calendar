import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CalendarState extends Equatable {
  final int moment;

  const CalendarState(this.moment);

  @override
  List<Object> get props => [moment];
}


