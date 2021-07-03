import 'package:flutter/material.dart';

class FillterShowBottomSheet extends StatefulWidget {
  @override
  _FillterShowBottomSheetState createState() => _FillterShowBottomSheetState();
}

class _FillterShowBottomSheetState extends State<FillterShowBottomSheet> {
  @override
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
              "Looking to",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Chip(
                  label: Text('Buy'),
                  backgroundColor: Colors.lightBlueAccent,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Chip(
                  label: Text('Rent/Lease'),
                  backgroundColor: Colors.lightBlueAccent,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Chip(
                  label: Text('PG/Co-Living'),
                  backgroundColor: Colors.lightBlueAccent,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Purpose Of Buying",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Chip(
                  label: Text('Residential'),
                  backgroundColor: Colors.lightBlueAccent,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Chip(
                  label: Text('Commercial use'),
                  backgroundColor: Colors.lightBlueAccent,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'City Name',
                hintText: "Where ?",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  color: Colors.lightBlueAccent,
                  onPressed: () {},
                ),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.only(left:5.0,right: 5.0,top:20.0,bottom: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Explore',
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
