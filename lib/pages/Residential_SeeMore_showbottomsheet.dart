import 'package:flutter/material.dart';
import 'package:onclickproperty/pages/Commercial_Tab.dart';

class ResidentialSeeMoreShowBottomSheet extends StatefulWidget {
  @override
  _ResidentialSeeMoreShowBottomSheetState createState() => _ResidentialSeeMoreShowBottomSheetState();
}

class _ResidentialSeeMoreShowBottomSheetState extends State<ResidentialSeeMoreShowBottomSheet> {
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
              title: const Text('Residential Apartment'),
              subtitle: Text('Ringing after 12 hours'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Independent Home/Villa'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Plot/Land'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Bulider Floor'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Faram House'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Serviced Apartment'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: const Icon(Icons.home),
              title: const Text('Studio Apartment'),
              value: this.valuefirst,
              onChanged: (bool value) {
                setState(() {
                  this.valuefirst = value;
                });
              },
            ),
            Center(
              child: GestureDetector(
                onTap:()
                {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return CommercialTabPage();
                  }),);
                },
                child: Text(
                  "Looking For a Commericial Property?",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0,
                  ),
                ),
              ),
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
