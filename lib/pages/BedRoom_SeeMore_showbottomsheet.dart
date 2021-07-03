import 'package:flutter/material.dart';

class BedRoomSeeMoreShowBottomSheet extends StatefulWidget {
  @override
  _BedRoomSeeMoreShowBottomSheetState createState() => _BedRoomSeeMoreShowBottomSheetState();
}

class _BedRoomSeeMoreShowBottomSheetState extends State<BedRoomSeeMoreShowBottomSheet> {
  @override
  bool valuefirst = false;
  bool valuesecond = false;
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          ),),
        child: new Wrap(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Select Type Of Property",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            CheckboxListTile(
              title: const Text('1 RK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('1 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('1.5 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('2 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('2.5 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('3 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('3.5 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('4 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('4.5 BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('5+ BHK'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),


                Padding(
                  padding: const EdgeInsets.only(left:5.0,right: 5.0,top:10.0,bottom: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Apply',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
