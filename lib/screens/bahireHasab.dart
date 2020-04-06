import 'package:flutter/material.dart';
import 'package:abushakir/abushakir.dart';
import 'package:ethiopian_calendar/size_config.dart';

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
              style: TextStyle(
                  fontSize: 2.45 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 1.225 * SizeConfig.heightMultiplier),
              width: 23.15 * SizeConfig.widthMultiplier,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  border: new Border.all(color: Colors.black38)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 3.47 * SizeConfig.widthMultiplier),
                child: DropdownButton<int>(
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 5.5 * SizeConfig.imageSizeMultiplier,
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
          height: 1.225 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 4.63 * SizeConfig.widthMultiplier,
              vertical: 0.98 * SizeConfig.heightMultiplier),
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
          padding: EdgeInsets.symmetric(
              horizontal: 4.63 * SizeConfig.widthMultiplier),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildDaysandConstants(meskerem1),
              _buildDaysandConstants(wengelawi),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 4.63 * SizeConfig.widthMultiplier,
              right: 4.63 * SizeConfig.widthMultiplier,
              top: 2.45 * SizeConfig.heightMultiplier,
              bottom: 1.2255 * SizeConfig.heightMultiplier),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                      endIndent: 3.47 * SizeConfig.widthMultiplier,
                    )
                  ],
                ),
              ),
              Text(
                "በአላት",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 3.06 * SizeConfig.textMultiplier),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                      indent: 3.47 * SizeConfig.widthMultiplier,
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
      height: 7.35 * SizeConfig.heightMultiplier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${payload['key']}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 2.818 * SizeConfig.textMultiplier),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(right: 2.31 * SizeConfig.widthMultiplier),
            child: Text(
              "${payload['value']}",
              style: TextStyle(fontSize: 1.96 * SizeConfig.textMultiplier),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void computeBahireHasab(int year) {
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
          padding: EdgeInsets.symmetric(
              horizontal: 4.63 * SizeConfig.widthMultiplier,
              vertical: 1.225 * SizeConfig.heightMultiplier),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                bealat[index]["beal"],
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 2.33 * SizeConfig.textMultiplier),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                      indent: 6.9 * SizeConfig.widthMultiplier,
                      endIndent: 6.9 * SizeConfig.widthMultiplier,
                    )
                  ],
                ),
              ),
              Text(
                "${bealat[index]["day"]["month"]}, ${bealat[index]["day"]["date"]}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 2.33 * SizeConfig.textMultiplier),
              ),
            ],
          ),
        );
      },
    );
  }
}
