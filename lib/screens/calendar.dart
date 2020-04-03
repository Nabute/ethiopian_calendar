import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abushakir/abushakir.dart';
import 'package:ethiopian_calendar/blocs/blocs.dart';

class MyCalendar extends StatelessWidget {
//  int today;
  List<Text> _days = [
    Text(
      "ሰ",
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    ),
    Text("ማ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    Text("ረ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    Text("ሐ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    Text("አ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    Text("ቅ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    Text("እ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
  ];

  String clockDivision(int hour) {
    if (hour >= 0 && hour <= 4)
      return "ከሌሊቱ";
    else if (hour >= 5 && hour <= 9)
      return "ከጠዋቱ";
    else if (hour >= 10 && hour <= 12)
      return "ከረፋዱ";
    else if (hour >= 13 && hour <= 16)
      return "ከሰአት";
    else
      return "ከምሽቱ";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(child: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              final month = state.moment;
              return Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: _nameAndActions(context, month)),
                  _dayNames(),
                  Expanded(child: _daysGridList(context, month)),
                ],
              );
            },
          )),
          Container(
            padding: EdgeInsets.only(top: 0.0),
            child: StreamBuilder<int>(
              stream: EtDatetime.now().clock(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                else if (snapshot.connectionState == ConnectionState.done)
                  return Text("Clock Stopped.",
                      style: TextStyle(color: Colors.black));
                else if (snapshot.hasError)
                  return Text('Error Occured.',
                      style: TextStyle(color: Colors.black));
                else {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: _myTime(
                                  EtDatetime.fromMillisecondsSinceEpoch(
                                      snapshot.data)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: _myDate(
                                  EtDatetime.fromMillisecondsSinceEpoch(
                                      snapshot.data)),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameAndActions(BuildContext context, ETC a) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.chevron_left),
          color: Colors.black,
          iconSize: 30.0,
          onPressed: () {
            BlocProvider.of<CalendarBloc>(context).add(PrevMonthCalendar(a));
          },
        ),
        Text(
          "${a.monthName}, ${a.year}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 19.0, color: Colors.black),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          iconSize: 30.0,
          onPressed: () {
            BlocProvider.of<CalendarBloc>(context).add(NextMonthCalendar(a));
          },
        ),
      ],
    );
  }

  Widget _dayNames() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _days.asMap().entries.map((MapEntry map) {
          return Container(
            child: map.value,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          );
        }).toList());
  }

  Widget _daysGridList(BuildContext context, ETC a) {
    int today;
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(3),
      crossAxisCount: 7,
      children: List.generate(
          a.monthDays().toList().length + a.monthDays().toList()[0][3],
          (index) {
        if (a.monthDays().toList()[0][3] > 0 &&
            index < a.monthDays().toList()[0][3]) {
          // NULL printer
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              height: 10.0,
              width: 10.0,
              child: Text(
                "",
                style: TextStyle(color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          );
        } else {
          if (a.monthDays().toList()[index - a.monthDays().toList()[0][3]][2] ==
              today) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 10.0,
                width: 10.0,
                child: Text(
                  "${a.monthDays().toList()[index - a.monthDays().toList()[0][3]][2]}",
                  style: TextStyle(color: Colors.black),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal[300],
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              height: 10.0,
              width: 10.0,
              child: Text(
                "${a.monthDays().toList()[index - a.monthDays().toList()[0][3]][2]}",
                style: TextStyle(color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _myTime(EtDatetime dt) {
    int hour = 11, minute = 11, second = 11;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: Text(
            clockDivision(dt.hour),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
          ),
        ),
        Text(
          "${(dt.hour < 10) ? "0" + (dt.hour == 0 ? 12 + 6 : dt.hour + 6).toString() : ((dt.hour + 6) % 12 < 10 ? "0" + ((dt.hour + 6) % 12).toString() : ((dt.hour + 6) % 12))}:${(dt.minute < 10) ? "0" + dt.minute.toString() : dt.minute}:",
          style: TextStyle(fontSize: 70, fontWeight: FontWeight.w200),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
              "${(dt.second < 10) ? "0" + dt.second.toString() : dt.second}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
        ),
      ],
    );
  }

  Widget _myDate(EtDatetime dt) {
    return Row(
      children: <Widget>[
        Text(
          "${dt.monthGeez} ${(dt.day < 10) ? "0" + dt.day.toString() : dt.day}, ${dt.year}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
