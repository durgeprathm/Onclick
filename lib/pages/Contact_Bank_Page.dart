import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/const/const.dart';

class ContactBankPage extends StatefulWidget {
  @override
  _ContactBankPageState createState() => _ContactBankPageState();
}

class _ContactBankPageState extends State<ContactBankPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  String Deactivateat;
  bool showResetIcon = false;
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    final FirstField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.user,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Full Name",
      ),
    );
    final SecondField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.envelope,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
      ),
    );
    final ThirdField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.mobileAlt,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Mobile Number",
      ),
    );
    final FourthField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.graduationCap ,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "your Occupation",
      ),
    );
    final FifithField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.rupeeSign ,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Monthly Income",
      ),
    );
    final CheckButon = FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      color: primarycolor,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      onPressed: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (_) {
        //     return HomePage();
        //   }),
        // );
      },
      child: Text("Request Callback",
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
    final DropDownBankButon = DropdownSearch(
      items: [
        "Home Loan",
        "Mortgage Loan",
        "Personal Loan",
        "business Loan",
      ],
      showClearButton: true,
      //showSearchBox: true,
      //label: 'Select Loan Type ',
      onChanged: (value) {
      },
      dropdownSearchDecoration:  InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText:  "Select Loan Type" ,
          hintStyle:style,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.list ,
            color: primarycolor,
          ),
        ),
        //border: OutlineInputBorder(),
      ),
    );
    final DateButon = DateTimeField(
      format: format,
      style: style,
      keyboardType: TextInputType.number,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate:
            currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      autovalidate: autoValidate,
      // style: labelTextStyle,
      validator: (date) =>
      date == null ? 'Invalid date' : null,
      onChanged: (date) => setState(() {}),
      onSaved: (date) => setState(() {

      }),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Date",

        prefixIcon:Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.calendarDay,
            color: primarycolor,
          ),
        ),
        //border: OutlineInputBorder(),
      ),

    );



    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('images/loan.png'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Bank Loan",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                color: primarycolor,
              ),
            ),
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: OutlineButton(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: new BorderRadius.circular(10.0),
        //       ),
        //       onPressed: () {
        //         // Navigator.of(context)
        //         //     .push(MaterialPageRoute(builder: (_) {
        //         //   return PostProperty();
        //         // }),);
        //       },
        //       borderSide: BorderSide(
        //         color: primarycolor,
        //         style: BorderStyle.solid,
        //       ),
        //       child: Text("Post Property",
        //           textAlign: TextAlign.center,
        //           style: style.copyWith(
        //               fontSize: 10.0,
        //               color: primarycolor, fontWeight: FontWeight.bold)),
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text("Your Contact Bank Loan Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color:primarycolor
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 8.0),
                child: Column(
                  children: [
                    SizedBox(height: 18.0),
                    FirstField,
                    SizedBox(height: 15.0),
                    SecondField,
                    SizedBox(height: 15.0),
                    ThirdField,
                    SizedBox(height: 15.0),
                    DateButon,
                    SizedBox(height: 15.0),
                    FourthField,
                    SizedBox(height: 15.0),
                    FifithField,
                    SizedBox(height: 15.0),
                    DropDownBankButon,
                    SizedBox(height: 15.0),
                    CheckButon,
                    // SizedBox(height: 15.0),
                    // ResgisterButon,
                    SizedBox(
                      height: 3.0,
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
        ),
      );
  }
}
