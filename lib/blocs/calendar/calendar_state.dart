import 'package:equatable/equatable.dart';
import 'package:abushakir/abushakir.dart';
import 'package:meta/meta.dart';

abstract class CalendarState extends Equatable {
  final ETC moment;

  const CalendarState(this.moment);

  @override
  List<Object> get props => [moment];
}

class Month extends CalendarState {
  final ETC currentMonth;

  const Month(this.currentMonth) : super(currentMonth);

  @override
  List<Object> get props => [currentMonth];

  @override
  String toString() => "Today's Calendar { Calendar: $currentMonth }";
}

