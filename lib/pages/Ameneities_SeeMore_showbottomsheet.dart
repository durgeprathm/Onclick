import 'package:flutter/material.dart';

class AmeneitiesSeeMoreShowBottomSheet extends StatefulWidget {
  @override
  _AmeneitiesSeeMoreShowBottomSheetState createState() => _AmeneitiesSeeMoreShowBottomSheetState();
}

class _AmeneitiesSeeMoreShowBottomSheetState extends State<AmeneitiesSeeMoreShowBottomSheet> {
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
              "Select Amenities",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Parking'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Lift'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Power Backup'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Gas Pipeline'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Swimming Pool'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Gymnasium'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Club House'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Park'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),

            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Security Personal'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),

            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('WheelChair Friendly'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),

            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Pet Friendly'),
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
