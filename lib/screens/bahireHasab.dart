import 'package:flutter/material.dart';

class MyBahireHasab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    prefixIcon: Icon(Icons.event),
                    labelText: 'Enter a Year',
                    isDense: true),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val.length > 4) {
                    return "Year should be multiple of thousand";
                  } else {
                    return null;
                  }
                },
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
              _buildDaysandConstants({'description': "Wenber", "value": 12}),
              _buildDaysandConstants({'description': "Metkih", "value": 12}),
              _buildDaysandConstants({'description': "Abekte", "value": 12}),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildDaysandConstants(
                  {'description': "Year Start Day", "value": "ማግሰኞ"}),
              _buildDaysandConstants(
                  {'description': "Evangelist", "value": "ሉቃስ"}),
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
            "${payload['value']}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              payload['description'],
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeastandHoliday() {
    List<Map<String, dynamic>> bealat = [
      {
        "beal": "ነነዌ",
        "day": {"month": "የካቲት", "date": 11}
      },
      {
        "beal": "ዓቢይ ጾም",
        "day": {"month": "የካቲት", "date": 25}
      },
      {
        "beal": "ደብረ ዘይት",
        "day": {"month": "መጋቢት", "date": 22}
      },
      {
        "beal": "ሆሣዕና",
        "day": {"month": "ሚያዝያ", "date": 13}
      },
    ];
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
