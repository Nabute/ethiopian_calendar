import 'package:flutter/material.dart';
import 'package:abushakir/abushakir.dart';

class MyBahireHasab extends StatefulWidget {
  @override
  _MyBahireHasabState createState() => _MyBahireHasabState();
}

class _MyBahireHasabState extends State<MyBahireHasab> {
  int dropdownValue;
  List<DropdownMenuItem<int>> dropDownMenuItems;

  Map<String, dynamic> wenber = {"key": "ወንበር"};
  Map<String, dynamic> metkih = {"key": "መጥቅህ"};
  Map<String, dynamic> abekte = {"key": "አበቅቴ"};

  Map<String, dynamic> meskerem1 = {"key": "መስከረም 1"};
  Map<String, dynamic> wengelawi = {"key": "ወንጌላዊ"};

  List<dynamic> bealat = [];

  @override
  void initState() {
    dropDownMenuItems = getDropDownMenuItems();
    dropdownValue = EtDatetime.now().year;
    computeBahireHasab(dropdownValue);
    super.initState();
  }

  List<DropdownMenuItem<int>> getDropDownMenuItems() {
    List<DropdownMenuItem<int>> items = new List();
    for (int i = 1900; i < 2100; i++) {
      items.add(new DropdownMenuItem(value: i, child: new Text(i.toString())));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Please Select a year ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              width: 100,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  border: new Border.all(color: Colors.black38)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: DropdownButton<int>(
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    isDense: true,
                    autofocus: true,
                    style: TextStyle(color: Colors.black),
                    onChanged: (int newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        computeBahireHasab(newValue);
                      });
                    },
                    items: dropDownMenuItems),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildDaysandConstants(abekte),
              _buildDaysandConstants(metkih),
              _buildDaysandConstants(wenber),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildDaysandConstants(meskerem1),
              _buildDaysandConstants(wengelawi),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                      endIndent: 15,
                    )
                  ],
                ),
              ),
              Text(
                "በአላት",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                      indent: 15,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: _buildFeastandHoliday(),
        )
      ],
    );
  }

  Widget _buildDaysandConstants(Map<String, dynamic> payload) {
    return Container(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${payload['key']}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              "${payload['value']}",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void computeBahireHasab(int year){
    BahireHasab bh = new BahireHasab(year: year);
    wenber['value'] = bh.wenber;
    abekte['value'] = bh.abekte;
    metkih['value'] = bh.metkih;
    meskerem1['value'] = bh.getMeskeremOne();
    wengelawi['value'] = bh.getEvangelist(returnName: true);

    bealat = bh.allAtswamat;

  }

  Widget _buildFeastandHoliday() {
    return ListView.builder(
      itemCount: bealat.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                bealat[index]["beal"],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                      indent: 30,
                      endIndent: 30,
                    )
                  ],
                ),
              ),
              Text(
                "${bealat[index]["day"]["month"]}, ${bealat[index]["day"]["date"]}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
              ),
            ],
          ),
        );
      },
    );
  }
}
