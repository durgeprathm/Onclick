import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class SortShowBottomSheet extends StatefulWidget {
  final int sortRadioValue;
  Function getSortRadioValue;

  SortShowBottomSheet(this.sortRadioValue, this.getSortRadioValue);

  @override
  _SortShowBottomSheetState createState() =>
      _SortShowBottomSheetState(this.sortRadioValue, this.getSortRadioValue);
}

class _SortShowBottomSheetState extends State<SortShowBottomSheet> {
  final int sortRadioValue;
  Function getSortRadioValue;

  _SortShowBottomSheetState(this.sortRadioValue, this.getSortRadioValue);

  int _sortRadioValue = 1;

  @override
  void initState() {
    super.initState();
    _sortRadioValue = sortRadioValue;
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _sortRadioValue = value;
    });
    getSortRadioValue(value);
    Navigator.pop(context);
    print(
        "first" + value.toString() + "radiovalue" + _sortRadioValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        // padding: EdgeInsets.all(20.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        // margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: <Widget>[
              Center(
                  child: Container(
                      height: getProportionateScreenHeight(3.0),
                      width: getProportionateScreenWidth(50.0),
                      color: Colors.grey)),
              SizedBox(
                height: getProportionateScreenHeight(10.0),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Sort By',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(14)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(10.0),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: kPrimaryColor,
                        value: 1,
                        groupValue: _sortRadioValue,
                        onChanged: (value) {
                          setState(() {
                            _sortRadioValue = value;
                          });
                          print("radiofirst" +
                              value.toString() +
                              "radiovalue" +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(value);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _sortRadioValue = 1;
                          });
                          print("radiofirst" +
                              '1' +
                              "radiovalue" +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(1);
                        },
                        child: Text(
                          'Relevance',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12)),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Radio(
                        activeColor: kPrimaryColor,
                        value: 2,
                        groupValue: _sortRadioValue,
                        onChanged: (value) {
                          setState(() {
                            _sortRadioValue = value;
                          });
                          print("radiosecond " +
                              value.toString() +
                              "radiovalue " +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(value);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _sortRadioValue = 2;
                          });
                          print("radiofirst" +
                              '2' +
                              "radiovalue" +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(2);
                        },
                        child: Text(
                          'Newest first',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12)),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Radio(
                        activeColor: kPrimaryColor,
                        value: 3,
                        groupValue: _sortRadioValue,
                        onChanged: (value) {
                          setState(() {
                            _sortRadioValue = value;
                          });
                          print("radiofirst" +
                              value.toString() +
                              "radiovalue" +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(value);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _sortRadioValue = 3;
                          });
                          print("radiofirst" +
                              '3' +
                              "radiovalue" +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(3);
                        },
                        child: Text(
                          'Price: Low to High',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12)),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Radio(
                        activeColor: kPrimaryColor,
                        value: 4,
                        groupValue: _sortRadioValue,
                        onChanged: (value) {
                          setState(() {
                            _sortRadioValue = value;
                          });
                          print("radiosecond " +
                              value.toString() +
                              "radiovalue " +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(value);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _sortRadioValue = 4;
                          });
                          print("radiofirst" +
                              '4' +
                              "radiovalue" +
                              _sortRadioValue.toString());
                          _handleRadioValueChange(4);
                        },
                        child: Text(
                          'Price: High to Low',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(12)),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
