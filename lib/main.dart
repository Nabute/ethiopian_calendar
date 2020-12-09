import 'package:flutter/material.dart';
import 'package:abushakir/abushakir.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ethiopian_calendar/blocs/blocs.dart';
import 'package:ethiopian_calendar/screens/calendar.dart';
import 'package:ethiopian_calendar/screens/bahireHasab.dart';

import 'package:ethiopian_calendar/size_config.dart';

void main() => runApp(MyApp());

const List<String> _weekdays = [
  "ሰ",
  "ማ",
  "ረ",
  "ሐ",
  "አ",
  "ቅ",
  "እ",
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Ethiopian Calendar',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MultiBlocProvider(
                providers: [
                  BlocProvider<CalendarBloc>(
                    create: (BuildContext context) =>
                        CalendarBloc(currentMoment: ETC.today()),
                  ),
                ],
                child: MyHomePage(title: 'Abushakir'),
              ),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EtDatetime a = new EtDatetime.now();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[MyCalendar(), MyBahireHasab()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.black, fontSize: 3.1 * SizeConfig.textMultiplier),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.language),
        //     color: Colors.black,
        //   )
        // ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 1.96 * SizeConfig.textMultiplier)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            title: Text('BahireHasab',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 1.96 * SizeConfig.textMultiplier)),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
