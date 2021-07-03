import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';

class dummy extends StatefulWidget {
  @override
  _dummyState createState() => _dummyState();
}

class _dummyState extends State<dummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("hello"),
    ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 20.0, left: 12.0, right: 12.0),
                child: Container(
                  child: TextField(
                    //  controller: SerachController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: primarycolor, width: 2.0),
                          // borderRadius:
                          // BorderRadius.all(Radius.circular(40.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: primarycolor, width: 2.0),
                          // borderRadius:
                          // BorderRadius.all(Radius.circular(40.0)),
                        ),
                        hintText: "Items Search..",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                          ),
                          color: primarycolor,
                          onPressed: () {},
                        )),
                  ),
                ),
              ),
            ),
            Expanded(

              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
    }),
    ),
            ),
          ],
        ),
      ));
  }
}
