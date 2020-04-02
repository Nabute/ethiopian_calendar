import 'package:equatable/equatable.dart';
import 'package:abushakir/abushakir.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class TodaysCalendar extends CalendarEvent {
  final ETC currentMonth;

  const TodaysCalendar(this.currentMonth);

  @override
  List<Object> get props => [currentMonth];

  @override
  String toString() => "Today's Calendar { Calendar: $currentMonth }";
}

class NextMonthCalendar extends CalendarEvent {
  final ETC currentMonth;

  const NextMonthCalendar(this.currentMonth);

  @override
  List<Object> get props => [currentMonth.nextMonth ];

  @override
  String toString() => "Next Month's Calendar { Calendar: ${currentMonth.nextMonth} }";
}

class PrevMonthCalendar extends CalendarEvent {
  final ETC currentMonth;

  const PrevMonthCalendar(this.currentMonth);

  @override
  List<Object> get props => [currentMonth.prevMonth ];

  @override
  String toString() => "Previous Month's Calendar { Calendar: ${currentMonth.prevMonth} }";
}
