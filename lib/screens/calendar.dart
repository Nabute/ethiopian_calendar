import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abushakir/abushakir.dart';
import 'package:ethiopian_calendar/blocs/blocs.dart';
import 'package:ethiopian_calendar/size_config.dart';

const List<String> _dayNumbers = [
  "፩",
  "፪",
  "፫",
  "፬",
  "፭",
  "፮",
  "፯",
  "፰",
  "፱",
  "፲",
  "፲፩",
  "፲፪",
  "፲፫",
  "፲፬",
  "፲፭",
  "፲፮",
  "፲፯",
  "፲፰",
  "፲፱",
  "፳",
  "፳፩",
  "፳፪",
  "፳፫",
  "፳፬",
  "፳፭",
  "፳፮",
  "፳፯",
  "፳፰",
  "፳፱",
  "፴",
];

class MyCalendar extends StatelessWidget {
  EtDatetime _today = EtDatetime.now();


  List<Text> _days = [
    Text(
      "ሰ",
      style: TextStyle(
          fontSize: 2.08335 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.bold),
    ),
    Text("ማ",
        style: TextStyle(
            fontSize: 2.08335 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold)),
    Text("ረ",
        style: TextStyle(
            fontSize: 2.08335 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold)),
    Text("ሐ",
        style: TextStyle(
            fontSize: 2.08335 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold)),
    Text("አ",
        style: TextStyle(
            fontSize: 2.08335 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold)),
    Text("ቅ",
        style: TextStyle(
            fontSize: 2.08335 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold)),
    Text("እ",
        style: TextStyle(
            fontSize: 2.08335 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.bold)),
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
                  Expanded(
                      child: GestureDetector(
                    onPanEnd: (e) {
                      if (e.velocity.pixelsPerSecond.dx < 0) {
                        BlocProvider.of<CalendarBloc>(context)
                            .add(NextMonthCalendar(month));
                      } else if (e.velocity.pixelsPerSecond.dx > 0) {
                        BlocProvider.of<CalendarBloc>(context)
                            .add(PrevMonthCalendar(month));
                      }
                    },
                    child: _daysGridList(context, month),
                  )),
                ],
              );
            },
          )),
          Container(
            child: StreamBuilder<int>(
              stream: EtDatetime.now().clock(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                else if (snapshot.connectionState == ConnectionState.done)
                  return Text("Clock Stopped.",
                      style: TextStyle(color: Colors.black));
                else if (snapshot.hasError)
                  return Text('Error Occurred.',
                      style: TextStyle(color: Colors.black));
                else {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            0.9803 * SizeConfig.heightMultiplier),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: _myTime(
                                  EtDatetime.fromMillisecondsSinceEpoch(
                                      snapshot.data +
                                          (3 *
                                              3600000) // since Ethiopian is GMT+3
                                      )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 4.803 * SizeConfig.heightMultiplier),
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
          iconSize: 6.94 * SizeConfig.imageSizeMultiplier,
          onPressed: () {
            BlocProvider.of<CalendarBloc>(context).add(PrevMonthCalendar(a));
          },
        ),
        Text(
          "${a.monthName}, ${a.year}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 3.177 * SizeConfig.textMultiplier,
              color: Colors.black),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          iconSize: 6.94 * SizeConfig.imageSizeMultiplier,
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
            padding: EdgeInsets.symmetric(
                horizontal: 4.63 * SizeConfig.widthMultiplier,
                vertical: 1.838 * SizeConfig.heightMultiplier),
          );
        }).toList());
  }

  Widget _daysGridList(BuildContext context, ETC a) {
    int today;
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(
          horizontal: 0.694 * SizeConfig.widthMultiplier,
          vertical: 0.3676 * SizeConfig.heightMultiplier),
      crossAxisCount: 7,
      children: List.generate(
          a.monthDays().toList().length + a.monthDays().toList()[0][3],
          (index) {
        if (a.monthDays().toList()[0][3] > 0 &&
            index < a.monthDays().toList()[0][3]) {
          // NULL printer
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0.98 * SizeConfig.heightMultiplier,
                horizontal: 1.852 * SizeConfig.widthMultiplier),
            child: Container(
              alignment: Alignment.center,
              height: 1.225 * SizeConfig.heightMultiplier,
              width: 2.315 * SizeConfig.widthMultiplier,
              child: Text(
                "",
                style: TextStyle(color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          );
        } else {
          // mark if currentday == today
          if (a.monthDays().toList()[index - a.monthDays().toList()[0][3]][0] ==
                  EtDatetime.now().year &&
              a.monthDays().toList()[index - a.monthDays().toList()[0][3]][1] ==
                  EtDatetime.now().month &&
              a.monthDays().toList()[index - a.monthDays().toList()[0][3]][2] ==
                  EtDatetime.now().day) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0.98 * SizeConfig.heightMultiplier,
                  horizontal: 1.852 * SizeConfig.widthMultiplier),
              child: Container(
                alignment: Alignment.center,
                height: 1.225 * SizeConfig.heightMultiplier,
                width: 2.315 * SizeConfig.widthMultiplier,
                child: Text(
                  "${a.monthDays().toList()[index - a.monthDays().toList()[0][3]][2]}",
                  style: TextStyle(color: Colors.black),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal[300],
                  borderRadius: BorderRadius.circular(55),
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0.98 * SizeConfig.heightMultiplier,
                horizontal: 1.852 * SizeConfig.widthMultiplier),
            child: Container(
              alignment: Alignment.center,
              height: 1.225 * SizeConfig.heightMultiplier,
              width: 2.315 * SizeConfig.widthMultiplier,
              child: Text(
                "${a.monthDays().toList()[index - a.monthDays().toList()[0][3]][2]}",
                style: TextStyle(color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _myTime(EtDatetime dt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: 1.225 * SizeConfig.heightMultiplier,
            right: 2.315 * SizeConfig.widthMultiplier,
          ),
          child: Text(
            clockDivision(dt.hour),
            style: TextStyle(
                fontSize: 5.016 * SizeConfig.textMultiplier,
                fontWeight: FontWeight.w100),
          ),
        ),
        Text(
          "${_formatHour(dt.hour + 6)}:${(dt.minute < 10) ? "0" + dt.minute.toString() : dt.minute}:",
          style: TextStyle(
              fontSize: 8.58 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w400),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 1.225 * SizeConfig.heightMultiplier,
          ),
          child: Text(
              "${(dt.second < 10) ? "0" + dt.second.toString() : dt.second}",
              style: TextStyle(
                  fontSize: 5.016 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.w300)),
        ),
      ],
    );
  }

  Widget _myDate(EtDatetime dt) {
    return Row(
      children: <Widget>[
        Text(
          "${dt.monthGeez} ${_dayNumbers[dt.day - 1]}, ${ConvertToEthiopic(dt.year)}",
          style: TextStyle(
              fontSize: 3.0 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  String _formatHour(int hour) {
    if (hour < 10) {
      return hour == 0 ? "12" : "0$hour";
    } else {
      return "${hour > 12 ? hour % 12 < 10 ? "0${hour % 12}" : hour % 12 : hour}";
    }
  }
}
