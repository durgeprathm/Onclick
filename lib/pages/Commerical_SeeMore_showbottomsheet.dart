import 'package:flutter/material.dart';
import 'package:onclickproperty/pages/Residential_Tab.dart';

class CommericalSeeMoreShowBottomSheet extends StatefulWidget {
  @override
  _CommericalSeeMoreShowBottomSheetState createState() => _CommericalSeeMoreShowBottomSheetState();
}

class _CommericalSeeMoreShowBottomSheetState extends State<CommericalSeeMoreShowBottomSheet> {
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
              secondary: const Icon(Icons.home),
              title: const Text('Ready to move Office Space'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Bare Shell Office Space'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Co-Working Office Space'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Commercial Shop'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Commercial Land/Inst.Land'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Ware House'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Hotel/Resorts'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Factory'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Space In Rentail Mall'),
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
