import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget({this.cardChild});
  final Widget cardChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 3),
            blurRadius: 7.0,
            spreadRadius: 5.0,
          )
        ],
      ),
    );
  }
}
